class AddDescriptionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :Description, :text
  end
end
