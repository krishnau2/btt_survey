class Response < ActiveRecord::Base
  attr_accessible :survey_id, :user_id, :answers_attributes
  attr_accessor :this

  belongs_to :survey
  belongs_to :user
  has_many :answers, :dependent => :destroy, :inverse_of => :response

  accepts_nested_attributes_for :answers, :allow_destroy => true#, :reject_if => lambda { |a| a[:content].blank? }

  validates_presence_of :survey
  validates_presence_of :user
  
end
