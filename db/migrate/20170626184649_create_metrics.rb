class CreateMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metrics do |t|
      t.integer :city_id

      t.float :max_temp, default: 0.0, null: false
      t.float :temp, default: 0.0, null: false
      t.float :min_temp, default: 0.0, null: false
      t.float :wind_speed, default: 0.0, null: false
      t.timestamps

      t.index :city_id
    end
  end
end
