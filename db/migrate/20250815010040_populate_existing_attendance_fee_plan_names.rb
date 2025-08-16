class PopulateExistingAttendanceFeePlanNames < ActiveRecord::Migration[7.1]
  def up
    # 既存のAttendanceデータでfee_planが存在するものに対して、fee_plan_nameを設定
    Attendance.includes(:fee_plan).where.not(fee_plan: nil).find_each do |attendance|
      if attendance.fee_plan_name.blank? && attendance.fee_plan.present?
        attendance.update_column(:fee_plan_name, attendance.fee_plan.name)
      end
    end
  end

  def down
    # ロールバック時はfee_plan_nameをクリア
    Attendance.update_all(fee_plan_name: nil)
  end
end
