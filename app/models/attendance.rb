class Attendance < ApplicationRecord
  belongs_to :student

  validates :entry, presence: true
  validates :fee, presence: true
end
