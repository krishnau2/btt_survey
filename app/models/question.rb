class Question < ActiveRecord::Base
  attr_accessible :content, :survey_id, :type, :question_type
  attr_accessor :question_type

  validates_presence_of :content
  validates_presence_of :survey_id
  validate :valid_option_types

  belongs_to :survey

  def self.option_types
  	[['Date Question', 'DateQuestion'], ['Numeric Question', 'NumericQuestion'], ['Easy Question', 'EasyQuestion']]
  end

  private
		def valid_option_types
		  unless ['DateQuestion','NumericQuestion','EasyQuestion'].include?(type)
			  errors.add(:type, 'is invalid')
		  end  
	  end  
end
