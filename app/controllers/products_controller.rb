class ProductsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:update, :edit, :destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "product was created successfully."
      redirect_to @product
    else
      render "new"
    end
  end

  def show
    if params[:id].length >= 6
      @product = Product.find_by(barcode: params[:id])
    else
      @product = Product.find(params[:id])
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :foreign_name, :barcode, :expiration_date)
  end
end
