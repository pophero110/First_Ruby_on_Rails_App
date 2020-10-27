class ProductsController < ApplicationController
  before_action :require_user, except: [:index, :show]

  def new
    @product = Product.new
  end

  def index
    @products = Product.filter(params.keys)
  end

  def create
    @product = Product.new(product_params)
    @product.quantity_in_total = @product.quantity_of_box * @product.quantity_per_box
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
      if @product == nil
        flash[:alert] = "Not found"
        redirect_to root_path
      end
    else
      @product = Product.find(params[:id])
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.quantity_in_total = @product.quantity_of_box * @product.quantity_per_box
    if @product.update(product_params)
      flash[:notice] = "product was updated successfully"
      redirect_to @product
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to @product
  end

  private

  def product_params
    params.require(:product).permit(:name, :foreign_name, :barcode, :expiration_date, :quantity_of_box, :quantity_per_box, :category_id)
  end
end
