class CreateWelcomes < ActiveRecord::Migration
  def change
    create_table :welcomes do |t|
      t.string :name
      t.string :logo
      t.string :decription
      t.string :imgs, array: true
      t.string :link, null: true
      t.string :org, null: true
      t.integer :view, null: true
      t.integer :viewhehe, null: true
      t.integer :love, null: true

      t.timestamps null: false
    end
  end
end
