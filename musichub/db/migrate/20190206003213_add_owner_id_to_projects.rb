class AddOwnerIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :owner_id, :integer
  end
end
