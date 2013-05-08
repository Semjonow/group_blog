class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :blog
  has_many :pictures, :class_name => 'RedactorRails::Picture', :as => :assetable

  field :text, :type => String
end