class Project < ApplicationRecord
  has_many :teams
  has_many :users, through: :teams

  accepts_nested_attributes_for :team


  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }

end
