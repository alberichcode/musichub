class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.belongs_to :owner, class_name: "User"
      t.string :name
      t.string :description
      t.date :due_date
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end