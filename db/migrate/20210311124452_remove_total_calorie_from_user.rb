class RemoveTotalCalorieFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :total_calorie, :string
  end
end
