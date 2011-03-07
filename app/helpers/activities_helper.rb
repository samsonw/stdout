module ActivitiesHelper
  def activity_count(model, page, count)
    model.class.per_page * (page.to_i - 1) + count + 1
  end
end
