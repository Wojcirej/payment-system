class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address
      t.string :contract_type, null: false
      t.decimal :hourly_rate, precision: 2
      t.decimal :monthly_rate, precision: 2
      t.decimal :provision, precision: 2

      t.timestamps
    end
  end
end
