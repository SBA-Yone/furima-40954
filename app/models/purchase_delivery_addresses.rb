class PurchaseDeliveryAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchase_id

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :address
    validates :phone_number
    validates :purchase_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    DeliveryAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
                           building_name: building_name, phone_number: phone_number, purchase_id: purchase_id)
  end

end