class AddTotalPriceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :total_price, :integer
  end
end
