module ActivitiesHelper
  def activity_count(model, page, count)
    model.class.per_page * (page.to_i - 1) + count + 1
  end
  
  def highlight_and_truncate(activity)
    truncated_str = truncate_u(activity.content, 80, ' ...')
    case activity.source.name
    when 'twitter'
      highlight_twitter(highlight_url(truncated_str))
    when 'github'
      highlight_github(truncated_str)
    else
      highlight_url(truncated_str)
    end
  end
  
  def highlight_twitter(str)
    str.gsub(/(@\w+)/, '<span class="highlight">\1</span>')
  end
  
  def highlight_github(str)
    str.gsub(/\[ (.*) \]/, '<span class="highlight_link"><a href="\1" target="_blank" title="github link">github link</a></span>')
  end
  
  def highlight_url(str)
    str.gsub(%r{(https?://\S+[^\s`!()\[\]{};:'".,<>?«»“”‘’])}, '<a rel="nofollow" target="_blank" title="\1" href="\1">\1</a>')
  end
end
