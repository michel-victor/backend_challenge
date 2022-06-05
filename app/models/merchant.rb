class Merchant < ApplicationRecord
  include DateHelpers

  has_many :orders
  has_many :shoppers, through: :orders

  has_many :disbursements

  validates :name, :email, :cif, presence: true

  # Calculate and persist disbursements for a merchant in a week given a date or number of week and optional year
  def disburse(date_or_week_number, year = Date.current.year)
    date = date_or_week_number.to_date rescue nil
    week = date_or_week_number.to_i rescue nil
    year = year.to_i rescue nil

    # Generate and validate week date range
    week_date_range = Merchant.week_date_range(date, week, year)

    # Get merchant orders completed between week date range and sum amounts with fee
    amount = orders.completed.where(completed_at: week_date_range).sum{ |order| order.amount_with_fee }

    # Persist disbursement amount for a merchant in a week.
    Disbursement.create!(merchant: self, amount: amount, date: week_date_range.first)
  end
end
