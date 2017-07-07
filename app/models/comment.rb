class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments
  belongs_to :user
end
