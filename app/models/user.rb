require 'openssl'

class User < ActiveRecord::Base
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password
  has_many :questions

  validates :email, :username, presence: true
  validates :username, length: {maximum: 40}
  validates :username, format: {with: /\A[\w]+\z/}

  validates :email, :username, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}\z/i}

  validates :password, presence: true, on: :create

  validates_confirmation_of :password

  before_validation :check_username
  before_save :encrypt_password, :downcase_fields

  def check_username
    self.username = username.downcase if username.present?
  end

  def downcase_fields
    self.username.downcase!
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )

    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end