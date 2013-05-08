require "nokogiri"

class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :blog
  belongs_to :user

  has_many :comments

  has_many :pictures, :class_name => "RedactorRails::Picture", :as => :assetable

  field :text, :type => String

  validate :text, :presence => true

  before_save do
    doc = Nokogiri::HTML(text)
    doc.css("style,script").remove
    self.text = doc.to_s
  end
end