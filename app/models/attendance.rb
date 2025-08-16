class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :fee_plan, optional: true

  validates :entry, presence: true
  validates :fee_plan_id, presence: true

  before_save :set_fee_plan_name

  private

  def set_fee_plan_name
    if fee_plan.present? && fee_plan_name.blank?
      self.fee_plan_name = fee_plan.name
    end
  end
end
