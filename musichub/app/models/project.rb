class Project < ApplicationRecord
  include PublicActivity::Model


  enum status: [:active, :complete]

  has_many :user_projects, foreign_key: "collaboration_project_id"
  has_many :collaborators, through: :user_projects
  belongs_to :owner, class_name: "User"

  scope :complete, -> { where(status: 1) }
  scope :active, -> { where(status: 0)}
  scope :overdue, -> { where("due_date < ? AND status = ?", Date.today, 0)}

  validates :name, :description, :due_date, :status, presence: true


 def collaborator_emails=(emails)
   email_array = emails.split(",").map{|email| email.strip}
   email_array.each do |email|
     collaborator = User.find_by(email: email)
     if collaborator == nil || collaborator == self.owner || self.collaborators.include?(collaborator)
       next
     end
     self.collaborators << collaborator
     self.save
   end
 end

 def collaborator_emails
   emails = self.collaborators.collect {|collaborator| collaborator.email}
   emails.join(", ")
 end

 def overdue?
   self.due_date < Date.today ? true : false
 end

end
