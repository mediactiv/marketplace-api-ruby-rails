class Api::V1::ProductsController < ApplicationController
  #@note @rails set default response mime type
  respond_to :json

  # filters executed before executing an action
  before_action :authenticate_with_token!, only: [:create,:update,:destroy]

  # index lists all products 
  def index
    if params[:user_id] && user = User.find(params[:user_id])
      if current_user && user == current_user
        respond_with current_user.products.all
      else
        respond_with user.find.products.all
      end
    else
      respond_with Product.all
    end
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
    product = current_user.products.find(params[:id])
    if product.update(product_params)
      render json: product,status:200,location:[:api,product]
    else
      render json: {errors:product.errors},status:422
    end
  end

  def destroy
    product = current_user.products.find(params[:id])
    product.destroy
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

end