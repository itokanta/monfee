class Student < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy

  validates :name, presence: true
  validates :age, presence: true
  validates :guardian_name, presence: true
  validates :phone_number, presence: true

  def total_fee(start_date = nil, end_date = nil)
    attendances = self.attendances
    if start_date && end_date
      attendances = attendances.where(entry: start_date..end_date)
    end
    attendances.sum(:fee)
  end
end
