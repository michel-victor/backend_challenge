class Disbursement < ApplicationRecord
  include DateHelpers

  belongs_to :merchant

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  # Validate that a disbursement is not duplicated for the same merchant in the same week
  validates :merchant, uniqueness: { scope: :date }

  # Return filtered disbursements by merchant_id
  def self.merchant(merchant_id)
    where(merchant: merchant_id)
  end

  # Return filtered disbursements by generated and validated week date range from date or {week.year}
  def self.week(date_or_week_number)
    date = date_or_week_number.to_date rescue nil
    week_year = date_or_week_number.split('.')
    week = week_year.first.to_i rescue nil
    year = week_year.last.to_i rescue nil

    where(date: Disbursement.week_date_range(date, week, year, exception: false))
  end
end
