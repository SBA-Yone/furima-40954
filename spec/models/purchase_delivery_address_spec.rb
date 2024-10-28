require 'rails_helper'

RSpec.describe PurchaseDeliveryAddress, type: :model do
  before do
    @purchase_delivery_address = FactoryBot.build(:purchase_delivery_address)
  end

  describe '配送先情報の登録' do
    context '登録できる場合' do
      it '全ての値が正しく入力されていれば登録できる' do
        expect(@purchase_delivery_address).to be_valid
      end

      it '建物名が空でも登録できる' do
        @purchase_delivery_address.building_name = ''
        expect(@purchase_delivery_address).to be_valid
      end
    end

    context '登録できない場合' do
      it '郵便番号が空では登録できない' do
        @purchase_delivery_address.postal_code = ''
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でないと登録できない' do
        @purchase_delivery_address.postal_code = '1234567'
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '都道府県が空では登録できない' do
        @purchase_delivery_address.prefecture_id = 0
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できない' do
        @purchase_delivery_address.city = ''
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では登録できない' do
        @purchase_delivery_address.address = ''
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では登録できない' do
        @purchase_delivery_address.phone_number = ''
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では登録できない' do
        @purchase_delivery_address.phone_number = '090123456'
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では登録できない' do
        @purchase_delivery_address.phone_number = '090123456789'
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が半角数値でないと登録できない' do
        @purchase_delivery_address.phone_number = '090-1234-5678'
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Phone number is invalid")
      end
      
      it "tokenが空では登録できない" do
        @purchase_delivery_address.token = nil
        @purchase_delivery_address.valid?
        expect(@purchase_delivery_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
