class AddTotalCalorieToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :total_calorie, :integer
  end
end
