FactoryBot.define do
  factory :vickey, class: Shopper do
    name { 'Vickey' }
    email { 'vickey@not_gmail.com' }
    nif { '411111111Z' }
  end

  factory :jennefer, class: Shopper do
    name { 'Jennefer' }
    email { 'jennefer@not_gmail.com' }
    nif { '411111112Z' }
  end
end
