class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :photo, null: false
      t.text :bio

      # Add an index for the photo column
      t.index :photo, unique: true

      t.timestamps
    end
  end
end

