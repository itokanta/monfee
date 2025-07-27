class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :fee_plan, optional: true

  validates :entry, presence: true
  validates :fee, presence: true
end
