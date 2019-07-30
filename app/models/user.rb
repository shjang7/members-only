# frozen_string_literal: true

class User < ApplicationRecord
  has_many      :posts
  before_save   :downcase_email
  before_create :generate_token
  validates :name, presence: true, length: { minimum: 4,
                                             maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def generate_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def update_token
    update_attribute(:remember_token, hex_encrypt(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(token)
    hex_encrypt(token) == remember_token
  end

  def hex_encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
