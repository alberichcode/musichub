class Team < ApplicationRecord
  has_many :users
  has_many :projectss

  accepts_nested_attributes_for :users, allow_destroy: true # se asigna a : en este caso user

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }

end
