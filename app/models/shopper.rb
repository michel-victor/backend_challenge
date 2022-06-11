class Shopper < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :merchants, through: :orders

  validates :name, :email, presence: true
  validates :nif, presence: true, uniqueness: { case_sensitive: false }
end
