class Invite
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :email, :type => String
  field :token, :type => String

  attr_accessible :email, :username, :password
  attr_accessor :username, :password

  validates :email,    :presence => true
  validates :token,    :presence => true, :uniqueness => true
  validates :username, :presence => true, :on => :update
  validates :password, :presence => true, :on => :update

  validate :uniqueness_username

  scope :by_token, lambda{ |t|  where(:token => t) }

  before_validation :add_token, :on => :create

  after_create do
    Mailer.invite(user.id, id).deliver
  end

  private

  def add_token
    generated_token = SecureRandom.hex(25)
    if Invite.by_token(generated_token).exists?
      add_token
    else
      self.token = generated_token
    end
  end

  def uniqueness_username
    if User.by_username(username).exists?
      errors.add(:username, :exists)
      false
    else
      true
    end
  end
end