class RemoveTotalPriceFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :total_price, :string
  end
end
