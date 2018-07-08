class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address
      t.string :contract_type, null: false
      t.decimal :hourly_rate, scale: 2, precision: 10
      t.decimal :monthly_rate, scale: 2, precision: 10
      t.decimal :provision, scale: 2, precision: 10

      t.timestamps
    end
  end
end
