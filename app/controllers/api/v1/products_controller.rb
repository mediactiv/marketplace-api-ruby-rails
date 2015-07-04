class Api::V1::ProductsController < ApplicationController
  #@note @rails set default response mime type
  respond_to :json

  # filters executed before executing an action
  before_action :authenticate_with_token!, only: [:create,:update,:destroy]

  # index lists all products 
  def index
    respond_with Product.all
  end
  # show shows a product
  def show
    respond_with Product.find(params[:id])
  end

  # create creates a new product
  def create
    product = current_user.products.build(product_params)
    if product.save
      #we use render because we want to return a 201 status code
      render json: product, status: 201, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def update
  end

  def destroy
    
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

end