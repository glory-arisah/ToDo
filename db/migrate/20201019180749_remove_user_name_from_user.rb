class RemoveUserNameFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :user_name
  end
end
