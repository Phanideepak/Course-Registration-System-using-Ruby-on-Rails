class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.integer :c_id, limit: 8
      t.integer :s_id, limit: 8
      t.integer :grade

      t.timestamps
    end
  end
end
