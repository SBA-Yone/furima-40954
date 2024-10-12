class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @item = Item.new
    
  end
end
