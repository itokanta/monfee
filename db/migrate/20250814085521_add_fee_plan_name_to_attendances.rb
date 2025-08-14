class AddFeePlanNameToAttendances < ActiveRecord::Migration[7.1]
  def change
    add_column :attendances, :fee_plan_name, :string
  end
end
