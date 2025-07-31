class RemoveIncorrectFeePlanIdFromAttendances < ActiveRecord::Migration[6.0]
  def change
    remove_index :attendances, :fee_plan_id_id if index_exists?(:attendances, :fee_plan_id_id)
    remove_column :attendances, :fee_plan_id_id, :bigint
  end
end
