class FeePlan < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :nullify
  
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :user, presence: true
end
