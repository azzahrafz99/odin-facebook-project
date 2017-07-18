class User < ApplicationRecord
  acts_as_voter

  before_save { self.email = email.downcase } 

  # validates :username, presence: true
  # validates :email, presence: true
  # validates :password, length: { minimum: 6 }, presence: true
  # validates :password_confirmation, presence: true

  has_many :events
  has_many :posts
  has_many :authorizations
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
