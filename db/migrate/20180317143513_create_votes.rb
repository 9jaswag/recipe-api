class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :votes, :upvotes
  end
end
