class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  scope :completed, -> { where.not completed_at: nil }
  scope :incomplete, -> { where completed_at: nil }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def disbursement_amount
    case amount
    when 0...50
      (amount - 0.01 * amount)
    when 50..300
      (amount - 0.0095 * amount)
    when proc { |n| n > 300 }
      (amount - 0.0085 * amount)
    end
  end
end
