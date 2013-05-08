class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post
  belongs_to :user

  field :text,  :type => String
  field :email, :type => String

  validate :text, :presence => true
  validate :email, :presence => true, :if => Proc.new{ |f| !f.user }
end