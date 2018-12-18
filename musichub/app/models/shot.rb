class Shot < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :shot_categories
  has_many :categories, through: :shot_categories
  mount_uploader :user_shot, UserShotUploader
  is_impressionable
  acts_as_votable

  validates :title, presence:true, length: {minimum: 3, maximum: 50}
  validates :description, presence:true, length: {minimum: 10}
end
