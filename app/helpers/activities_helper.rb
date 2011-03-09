module ActivitiesHelper
  def activity_count(model, page, count)
    model.class.per_page * (page.to_i - 1) + count + 1
  end
  
  def highlight_and_truncate(activity)
    truncated_str = truncate_u(activity.content, 80, ' ...')
    return truncated_str unless activity.source.name == 'twitter'
    highlight(truncated_str)
  end
  
  def highlight(str)
    str.gsub(/(@\w+)/, '<span class="highlight">\1</span>')
  end
end
