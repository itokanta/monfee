class FeePlan < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :nullify
  
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0, allow_blank: true }
  validates :user, presence: true
end
