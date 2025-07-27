class FeePlan < ApplicationRecord
  has_many :attendances, dependent: :nullify
  
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
