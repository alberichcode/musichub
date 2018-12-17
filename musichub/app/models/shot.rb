class Shot < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :user_shot, UserShotUploader
  is_impressionable
  acts_as_votable

  validates :title, presence:true, length: {minimum: 3, maximum: 50}
  validates :description, presence:true, length: {minimum: 10}
end
