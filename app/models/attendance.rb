class Attendance < ApplicationRecord
  belongs_to :student

  validates :entry, null: false
  validates :fee, null: false
end
