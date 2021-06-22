class Student < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :age, presence: true
  validates :guardian_name, presence: true
  validates :phone_number, presence: true
end
