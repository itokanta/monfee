class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :fee_plan

  validates :entry, presence: true
  validates :fee, presence: true
  validates :fee_plan, presence: true
end
