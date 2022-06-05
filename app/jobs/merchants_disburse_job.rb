class MerchantsDisburseJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Wait until next Monday
    MerchantsDisburseJob.set(wait_until: (Date.current + 1.week).beginning_of_week).perform_later

    # It goes through all the merchants and executes for each one the disbursements of the previous week
    Merchant.all.each{ |merchant| merchan.disburse (Date.current - 1.week).cweek }
  end
end
