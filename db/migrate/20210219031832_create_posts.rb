class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text       :content,              null: false
      t.integer    :price
      t.integer    :calorie            
      t.integer    :likes_cound        
      t.references :user,                 foreign_key: true
      t.timestamps
    end
  end
end
