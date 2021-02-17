class DropTypeFromUsers < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :type
    add_column :users, :type_of_users, :string
  end
end
