class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image
      t.string :ingredients
      t.string :preparation_description
      t.integer :upvotes
      t.integer :downvotes
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :recipes, :name, unique: true
    add_index :recipes, :upvotes
  end
end
