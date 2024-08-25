class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.references :session, null: false, foreign_key: true
      t.integer :emoji

      t.timestamps
    end
  end
end
