class Project < ApplicationRecord
  belongs_to :user
  belongs_to :team

  accepts_nested_attributes_for :user, allow_destroy: true # se asigna a : en este caso user

end
