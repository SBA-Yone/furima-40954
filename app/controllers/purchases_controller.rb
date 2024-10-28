class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_sold_and_not_owner, only: [:index, :create]
  before_action :redirect_if_owner, only: [:index, :create] # 追加

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_delivery_address = PurchaseDeliveryAddress.new
    render 'orders/index'
  end

  def create
    @purchase_delivery_address = PurchaseDeliveryAddress.new(purchase_params)
    if @purchase_delivery_address.valid?
      pay_item
      @purchase_delivery_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      Rails.logger.debug(@purchase_delivery_address.errors.full_messages) # エラーメッセージをログに出力
      render 'orders/index', status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def redirect_if_sold_and_not_owner
    return unless @item.purchase.present? && current_user.id != @item.user_id

    redirect_to root_path
  end

  def redirect_if_owner
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end
end
