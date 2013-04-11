class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :published_on, :status
end
