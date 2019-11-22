class Api::V1::ProductsController < ApplicationController
  def index
    @products = Spree::Product.all
    render json: @products , status: :ok
  end   
end  
