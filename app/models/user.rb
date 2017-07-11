class User < ApplicationRecord
  attr_accessor :remember_token

  acts_as_voter

  before_save { self.email = email.downcase }

  validates :username, presence:true
  validates :email, presence:true
  validates :password, presence:true
  validates :password_confirmation, presence:true

  has_many :events
  has_many :posts

  has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  has_attached_file :image, styles: { medium: "300x2300>", thumb: "100x100>" }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def self.digest(string)
    Digest::SHA1.hexdigest(string).to_s
    # cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    #                                               BCrypt::Engine.cost

    # BCrypt::Password.create(string)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    # self.remember_digest = User.digest(remember_token)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    # BCrypt::Password.new(remember_digest).is_password?(remember_token)
    remember_digest = Digest::SHA1.hexdigest(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # follows as user
  def follow(other_user)
    following << other_user
  end

  # unfollows as user
  def unfollow(other_user)
    following.delete(other_user)
  end

  def follow!(other_user)
    self.relationships.create(follower_id = other_user.id)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
