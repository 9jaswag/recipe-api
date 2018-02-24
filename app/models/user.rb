class User < ApplicationRecord
  attr_accessor :activation_token
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_activation_digest
  has_many :recipes
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :username, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  
  class << self
    # returns a random token
    def new_token
      SecureRandom.urlsafe_base64
    end

    # returns the hash digest of a given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  # sends email with activation link
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # returns true if a token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    # verify the token matches the digest
    BCrypt::Password.new(digest).is_password?(token)
  end

  # activate a user
  def activate
    update_columns(activated: true, activated_time: Time.zone.now)
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
