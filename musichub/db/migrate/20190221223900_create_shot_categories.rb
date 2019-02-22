class CreateShotCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :shot_categories do |t|
      t.integer :shot_id
      t.integer :category_id
    end
  end
end
