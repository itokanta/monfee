class AddFeePlanToAttendances < ActiveRecord::Migration[6.0]
  def change
    add_reference :attendances, :fee_plan, null: true, foreign_key: true
  end
end
