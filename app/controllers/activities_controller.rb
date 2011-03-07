class ActivitiesController < ApplicationController
  
  def index
    @page = params[:page] || 1
    @activities = Activity.paginate :page => @page, :order => 'publish_at DESC'
  end

end
