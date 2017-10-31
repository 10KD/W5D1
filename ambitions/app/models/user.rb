class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  has_many :goals
  has_many :comments


  after_initialize :ensure_token
  #prefv
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def ensure_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(username, pw)
    user = User.find_by(username: username)
    return nil unless user
    user && user.valid_password?(pw) ? user : nil
  end

  def valid_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
end
