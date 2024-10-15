require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.user = FactoryBot.create(:user)
  end

  describe '商品出品機能' do
    context '商品が出品できる場合' do
      it '必要事項がすべて存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end 
    context '商品が出品できる場合' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'infoが空では登録できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが半角数値以外では登録できない' do
        @item.price = '１０００'  
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが10,000,000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'categoryが--では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'sales_statusが--では登録できない' do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it 'shipping_feeが--では登録できない' do
        @item.shipping_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it 'prefectureが--では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'scheduled_deliveryが--では登録できない' do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
    end
  end
end