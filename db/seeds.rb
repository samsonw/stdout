# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Source.find_or_create_by_name :name=>"blog", :display_name=>"Weblog", :url=>"http://blog.samsonis.me/"
Source.find_or_create_by_name :name=>"twitter", :display_name=>"Twitter", :url=>"http://twitter.com/"
Source.find_or_create_by_name :name=>"sina", :display_name=>"新浪微博", :url=>"http://t.sina.com.cn/"
Source.find_or_create_by_name :name=>"douban", :display_name=>"豆瓣", :url=>"http://www.douban.com/"
