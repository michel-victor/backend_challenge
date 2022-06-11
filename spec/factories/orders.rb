FactoryBot.define do
  factory :order do
    association :merchant, factory: :rowe
    association :shopper, factory: :vickey
    amount { 150 }

    trait :under_50 do
      amount { 48.65 }
    end

    trait :between_50_300 do
      amount { 105.80 }
    end

    trait :over_300 do
      amount { 416.20 }
    end

    trait :completed do
      completed_at { DateTime.now }
    end
  end

  # factory :order_smaller_than_50 do
  #   merchant factory :rowe
  #   shopper factory :vickey
  #   amount { 48.65 }
  #   completed_at { '2022-06-11 14:57:47' }
  # end

  # factory :order_between_50_300 do
  #   merchant association factory :rowe
  #   shopper association factory :vickey
  #   amount { 105.80 }
  #   completed_at { '2022-05-25 12:23:05' }
  # end

  # factory :order_over_300 do
  #   merchant association factory :weissnat
  #   shopper association factory :jennefer
  #   amount { 416.20 }
  #   completed_at { '2022-06-10 22:35:21' }
  # end

  # factory :order_incomplete do
  #   merchant association factory :weissnat
  #   shopper association factory :jennefer
  #   amount { 15.50 }
  #   completed_at { nil }
  # end
end
