class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  belongs_to :user
  has_one_attached :image
  has_one :purchase

  validates :image, presence: true
  validates :name, presence: true
  validates :info, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, presence: true, numericality: { other_than: 0, message: "can't be blank" }
  validates :sales_status_id, presence: true, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 0, message: "can't be blank" }
  validates :prefecture_id, presence: true, numericality: { other_than: 0, message: "can't be blank" }
  validates :scheduled_delivery_id, presence: true, numericality: { other_than: 0, message: "can't be blank" }
end
