class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :published_on, :status, :questions_attributes

  validates_presence_of :name

  has_many :questions, :dependent => :destroy
  has_many :easy_questions, :dependent => :destroy
  has_many :numeric_questions, :dependent => :destroy
  has_many :date_questions, :dependent => :destroy

  accepts_nested_attributes_for :questions, :allow_destroy => true, :reject_if => lambda { |a| a[:content].blank? }


  def have_question?
  	questions_count > 0
  end

  def questions_count
  	questions.size
  end

end
