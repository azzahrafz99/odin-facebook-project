class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :username, presence:true
  validates :email, presence:true
  validates :password, presence:true
  validates :password_confirmation, presence:true

  has_many :events
  has_many :posts
  has_many :comments

  has_secure_password

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def User.new_remember_token
      SecureRandom.urlsafe_base64
  end

  def User.digest(token)
      Digest::SHA1.hexdigest(token.to_s)
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

  private

    def create_remember_token
        self.remember_token = User.digest(User.new_remember_token)
    end
end