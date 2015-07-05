class Api::V1::ProductsController < ApplicationController
  #@note @rails set default response mime type
  respond_to :json

  # filters executed before executing an action
  before_action :authenticate_with_token!, only: [:create,:update,:destroy]

  # index lists all products
  def index
    products = params[:product_ids].present? ?  get_product_list.find(params[:product_ids]) : get_product_list
    respond_with products
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

  # get_product_list gets products depending on wether a user_id paramter 
  # is present and whether
  def get_product_list
    if params[:user_id] && user = User.find(params[:user_id])
        user.find.products.all
    else
      Product.all
    end
  end
end