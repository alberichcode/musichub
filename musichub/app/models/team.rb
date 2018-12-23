class Team < ApplicationRecord
  has_many :users
  has_one :project

  accepts_nested_attributes_for :user, allow_destroy: true # se asigna a : en este caso user
end
