class AddTenantIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tenant_id, :integer
  end
end
