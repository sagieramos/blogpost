class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.string :title, null: false
      t.text :text
      t.integer :comments_counter, null: false, default: 0
      t.integer :likes_counter, null: false, default: 0

      t.timestamps
    end
  end
end

