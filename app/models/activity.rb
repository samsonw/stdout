class Activity < ActiveRecord::Base
  belongs_to :source
  
  cattr_reader :per_page
  @@per_page = 50
end
