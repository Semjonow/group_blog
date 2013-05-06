class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include Authenticable
  acts_as_authentic do |config|
    config.validate_email_field    = false
    config.validate_password_field = false
    config.merge_validates_uniqueness_of_login_field_options :scope => '_id', :case_sensitive => true
  end

  include Gravtastic
  gravtastic :size => 45, :filetype => "png", :secure => true

  attr_accessible :username, :password

  scope :by_email, lambda{ |e| where(:email => e) }

  def find_by_username_or_email(login)
    self.any_of({:username => login}, {:email => login})
  end
end