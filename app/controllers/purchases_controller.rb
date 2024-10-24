class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_delivery_address = PurchaseDeliveryAddress.new
    render 'orders/index'
  end

  def create
    @purchase_delivery_address = PurchaseDeliveryAddress.new(purchase_params)
    if @purchase_delivery_address.valid?
      @purchase_delivery_address.save
      redirect_to root_path
    else
      Rails.logger.info @purchase_delivery_address.errors.full_messages
      render 'orders/index', status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
