class Post < ApplicationRecord
  validates :title, presence:true
  validates :content, presence:true
  has_many :comments, as: :commentable
  belongs_to :user
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
