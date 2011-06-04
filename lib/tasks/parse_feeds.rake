require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'twitter'
%w(base64 json rest_client oauth).each { |dependency| require dependency }

namespace :feeds do
  desc "Parse rss/atom feeds and store the content into database"
  task :parse => :environment do
    puts "Starting to fetch blog feeds..."
    rss = Nokogiri::XML(open('http://blog.samsonis.me/feed/'))
    source_id = Source.find_by_name("blog").id
    rss.xpath('/rss/channel/item').each do |item|
      title = item.xpath('./title').first.content
      link = item.xpath('./link').first.content
      content = item.xpath('./description').first.content
      creator = item.xpath('./dc:creator').first.content
      publish_at = item.xpath('./pubDate').first.content
      Activity.find_or_create_by_title(:source_id => source_id, :title => title, :link => link, :content => content, :creator => creator, :publish_at => publish_at)
    end
  end
end

namespace :twitter do
  desc "Parse twitter timeline"
  task :parse => :environment do
    puts "Starting to fetch twitter tweets..."
    tweets = Twitter.user_timeline("samson959", :count => 200)
    source_id = Source.find_by_name("twitter").id
    if source_id
      tweets.each do |t|
        Activity.find_or_create_by_content(:source_id => source_id, :content => t.text, :creator => t.user.screen_name, :publish_at => t.created_at)
      end
    end
  end
end

namespace :sina do
  desc "Parse Sina timeline"
  task :parse => :environment do
    puts "Starting to fetch sina timeline..."
    consumer_key = '974029317'
    consumer_secret = '7e7e2a84a3ebb54166e88c1372dd84d5'
    # TODO: Config your Access token key & secret
    access_key = '[TODO: INPUT ACCESS_KEY]'
    access_secret = '[TODO: INPUT ACCESS_SECRET]'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, :site => "http://api.t.sina.com.cn")
    access_token = OAuth::AccessToken.new(consumer, access_key, access_secret)

    timeline = JSON.parse(access_token.get('/statuses/user_timeline.json').body)
    source_id = Source.find_by_name("sina").id
    timeline.each do |t|
      Activity.find_or_create_by_content(:source_id => source_id, :content => t['text'], :creator => t['user']['screen_name'], :publish_at => t['created_at'])
    end
  end
end

namespace :douban do
  desc "Parse douban rss/atom feeds and store the content into database"
  task :parse => :environment do
    puts "Starting to fetch douban broadcasts..."
    rss = Nokogiri::XML(open('http://www.douban.com/feed/people/samsonw/miniblogs'))
    source_id = Source.find_by_name("douban").id
    rss.xpath('/rss/channel/item').each do |item|
      title = item.xpath('./title').first.content
      link = item.xpath('./link').first.content
      content = item.xpath('./description').first.content
      creator = item.xpath('./dc:creator').first.content
      publish_at = item.xpath('./pubDate').first.content
      Activity.find_or_create_by_title(:source_id => source_id, :title => title, :link => link, :content => title, :creator => creator, :publish_at => publish_at)
    end
  end
end

namespace :github do
  desc "Parse github feeds and store the content into database"
  task :parse => :environment do
    puts "Starting to fetch github public activity..."
    # github seems have some ssl cert issue
    require 'openssl'
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    rss = Nokogiri::XML(open('https://github.com/samsonw.atom'))
    source_id = Source.find_by_name("github").id
    rss.xpath('/xmlns:feed/xmlns:entry').each do |item|
      title = item.xpath('./xmlns:title').first.content
      link = item.xpath('./xmlns:link').first[:href]
      content = item.xpath('./xmlns:content').first.content
      creator = item.xpath('./xmlns:author/xmlns:name').first.content
      publish_at = item.xpath('./xmlns:published').first.content
      Activity.find_or_create_by_content(:source_id => source_id, :title => title, :link => link, :content => "#{title} [ #{link} ]", :creator => creator, :publish_at => publish_at)
    end
  end
end

desc "Parse all things for stdout"
task :stdout => ['feeds:parse', 'twitter:parse', 'sina:parse', 'douban:parse', 'github:parse'] do
  puts "Done."
end
