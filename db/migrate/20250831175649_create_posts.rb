class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :text, null: false
      t.string :x_id, null: false
      t.integer :post_type, default: 0, null: false
      t.timestamps
    end
  end
end
