module ApplicationHelper
  def guest(email)
    User.new(:email => email)
  end
end
