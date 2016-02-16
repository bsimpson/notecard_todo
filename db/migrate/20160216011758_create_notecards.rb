class CreateNotecards < ActiveRecord::Migration[5.0]
  def change
    create_table :notecards do |t|
      t.string :title
      t.text :body
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.belongs_to :user
      t.timestamps
    end
  end
end
