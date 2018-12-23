class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :shots, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :teams
  has_many :projects
  
  acts_as_voter
  validates :name, presence: true, length: {minimum:2}
end
