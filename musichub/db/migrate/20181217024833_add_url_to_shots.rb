class AddUrlToShots < ActiveRecord::Migration[5.2]
  def change
    add_column :shots, :url, :string
  end
end
