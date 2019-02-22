class CreateProjectComments < ActiveRecord::Migration[5.2]
  def change
    create_table :project_comments do |t|
      t.string :name
      t.text :response
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end
  end
end
