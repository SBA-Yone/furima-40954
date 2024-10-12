class Item < ApplicationRecord

  has_many :items

  validates :name, presence: true
  validates :info, presence: true
  validates :category_id, npresence: true
  validates :sales_status_id, presence: true
  validates :shipping_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :scheduled_delivery_id, presence: true
  validates :price, presence: true
  validates :user, presence: true
  validates :image, presence: true

end
