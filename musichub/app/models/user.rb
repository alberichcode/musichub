class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable

  has_many :shots, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :projects

  has_many :user_projects, foreign_key: "collaborator_id"
  has_many :projects, foreign_key: "owner_id"
  has_many :collaboration_projects, through: :user_projects

  enum role: [:user, :admin]
  acts_as_voter
  acts_as_followable
  acts_as_follower
  validates :name, presence: true, length: {minimum:2}

  has_one_attached :avatar

  def all_active_projects
    self.projects.active + self.collaboration_projects
  end

  def active_projects
    self.projects.active
  end

  def complete_projects
    self.projects.complete
  end

  def overdue_projects
    self.projects.overdue
  end


  # new function to set the password without knowing the current
 # password used in our confirmation controller.
 def attempt_set_password(params)
   p = {}
   p[:password] = params[:password]
   p[:password_confirmation] = params[:password_confirmation]
   update_attributes(p)
 end

 def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
 end

 # new function to return whether a password has been set
 def has_no_password?
   self.encrypted_password.blank?
 end

 # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
 # Instead you should use `pending_any_confirmation`.
 def only_if_unconfirmed
   pending_any_confirmation {yield}
 end

 def password_required?
 # Password is required if it is being set, but not for new records
 if !persisted?
   false
 else
   !password.nil? || !password_confirmation.nil?
 end
end

  def self.search(param)
    return User.none if param.blank?

    param.strip!
    param.downcase!
    (name_matches(param) + email_matches(param)).uniq
  end
  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end




end
