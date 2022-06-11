FactoryBot.define do
  factory :disbursement do
    association :merchant, factory: :rowe
    amount { 100 }
    date { DateTime.now }
  end
end
