class User < ActiveRecord::Base
  validates :username, :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  before_save :ensure_session_token

  has_many :questions, inverse_of: :user
  has_many :answers, inverse_of: :user
  has_many :received_answers, through: :questions, source: :answers
  has_many :favorites, inverse_of: :user
  has_many :favorite_tags, through: :favorites, source: :tag
  has_many :favorite_taggables, through: :favorite_tags, source: :taggables
  has_many :favorite_tag_questions,
      -> { uniq },
      through: :favorite_taggables,
      source: :taggings,
      source_type: "Question"
  has_many :comments

  attr_reader :password

  def self.generate_new_token
    token = SecureRandom.base64
    while User.find_by_session_token(token)
      token = SecureRandom.base64
    end
    token
  end

  def self.find_by_creds(creds)
    user = User.find_by_username creds[:username]
    return user if user && user.is_password?(creds[:password])
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password::create(password)
  end

  def is_password?(password)
    BCrypt::Password::new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_new_token
  end

  def reset_session_token
    self.session_token = User.generate_new_token
    self.save!
    self.session_token
  end

end
