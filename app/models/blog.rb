class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :users
  has_many :posts
end