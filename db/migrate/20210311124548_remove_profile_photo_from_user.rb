class RemoveProfilePhotoFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :profile_photo, :string
  end
end
