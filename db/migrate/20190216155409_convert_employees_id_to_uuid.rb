class ConvertEmployeesIdToUuid < ActiveRecord::Migration[5.2]
  def up
    Migrations::ConvertTableIdToUuid.up(:employees)
  end

  def down
    Migrations::ConvertTableIdToUuid.down(:employees)
  end
end
