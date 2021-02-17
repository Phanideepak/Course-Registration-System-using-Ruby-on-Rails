class AddForeignKeyToRegistrations < ActiveRecord::Migration[5.2]
  def change
  	add_foreign_key :registrations, :courses, column: :c_id, limit: 8
  	add_foreign_key :registrations, :users, column: :s_id, limit: 8
  end
end
