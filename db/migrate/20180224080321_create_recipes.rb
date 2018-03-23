class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.string :preparation_description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :recipes, :name
  end
end
