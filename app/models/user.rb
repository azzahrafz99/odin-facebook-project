class User < ApplicationRecord
  attr_accessor :remember_token

  acts_as_voter

  before_save { self.email = email.downcase }

  validates :username, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, presence: true
  validates :password_confirmation, presence: true

  has_many :events
  has_many :posts

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  has_attached_file :image, styles: { medium: '300x2300>', thumb: '100x100>' }

  validates_attachment_content_type :image,
                                    content_type: ['image/jpg',
                                                   'image/jpeg',
                                                   'image/png']

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.digest(string)
    Digest::SHA1.hexdigest(string).to_s
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # follows as user
  def follow(other_user)
    following << other_user
    Notification.create(notify_type: 'follow', actor: self, user: other_user)
  end

  # unfollows as user
  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
