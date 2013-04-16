class User < ActiveRecord::Base
  attr_accessible :user_name, :email, :password, :password_confirmation
  attr_accessor :password

  before_validation :downcase_email
  before_save :encrypt_password
  before_create :create_email_verification_token

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :user_name
  validates_uniqueness_of :user_name

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is invalid"

  def self.authenticate(email, password)
  	user = find_by_email(email)
  	if user
	  	new_password_hash = BCrypt::Engine.hash_secret(password, user.password_salt) 
	  	user if user.password_hash == new_password_hash
	  end
  end

  def self.verify_email(email_token)
  	user = find_by_email_verification_token(email_token)
  	if user
  		user.update_attribute(:verified, true)
  		user
  	end
  end

  def verified?
  	verified == true
  end

  def admin?
  	admin == true
  end

  private

	  def downcase_email
	    self.email = self.email.downcase if self.email.present?
	  end

	  def encrypt_password
	  	if password.present?
	  		self.password_salt = BCrypt::Engine.generate_salt  
	      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt) 
	  	end
	  end
	  def create_email_verification_token
	  	self.email_verification_token = SecureRandom.urlsafe_base64(20)
	  end
end
