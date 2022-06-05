class Shopper < ApplicationRecord
  has_many :orders
  has_many :merchants, through: :orders

  validates :name, :email, :nif, presence: true
end
