class AddProjectIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :project_id, :integer
  end
end
