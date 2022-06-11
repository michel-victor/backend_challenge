FactoryBot.define do
  factory :merchant do
    name { 'Rowe' }
    email { 'info@rowe.com' }
    cif { 'B611111111' }
  end

  factory :rowe, class: Merchant do
    name { 'Rowe' }
    email { 'info@rowe.com' }
    cif { 'B611111111' }
  end

  factory :weissnat, class: Merchant do
    name { 'Weissnat' }
    email { 'info@weissnat.com' }
    cif { 'B611111112' }
  end
end
