class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category


  has_many :items
  has_one_attached :image

  validates :name, presence: true
  validates :info, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :sales_status_id, presence: true
  validates :shipping_fee_id, presence: true
  validates :prefecture_id, presence: true
  validates :scheduled_delivery_id, presence: true
  validates :price, presence: true
  validates :user, presence: true
  validates :image, presence: true

end
