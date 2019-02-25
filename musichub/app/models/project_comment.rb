class ProjectComment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new {|controller, model| controller.current_user}
  
  belongs_to :project
  belongs_to :user
end
