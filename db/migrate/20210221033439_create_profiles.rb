class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.text       :discription
      t.integer    :total_price
      t.integer    :total_calorie
      t.timestamps
    end
  end
end
