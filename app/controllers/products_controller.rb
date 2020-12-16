class ProductsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :set_product, only: [:update, :edit, :destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.all.includes(:category, :vendors).order(:updated_at).reverse_order
  end

  def create
    @product = Product.new(product_params.except("quantity_per_box", "quantity_of_box"))
    if !@product.quantity_in_total
      @product.quantity_in_total = product_params[:quantity_per_box].to_i * product_params[:quantity_of_box].to_i
    end

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
        redirect_to root_path + "?error=true" + "&" + "barcode=" + params[:id]
      end
    else
      @product = Product.find(params[:id])
      @productHistory = @product.product_histories.order(created_at: :desc)
    end
  end

  def edit
  end

  def update
    oldQuantity = @product.quantity_in_total
    if @product.update(product_params.except("quantity_per_box", "quantity_of_box"))
      if oldQuantity != @product.quantity_in_total
        changedQuantity = @product.quantity_in_total - oldQuantity
        @productHistory = ProductHistory.new(change_in_quantity: changedQuantity, product: @product)
        @productHistory.save
      end
      flash[:notice] = "product was updated successfully"
      redirect_to @product
    else
      render "edit"
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = @product.name.to_s + "was deleted successfully"
      redirect_to products_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to(:back)
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :foreign_name, :barcode, :expiration_date, :category_id, :quantity_in_total, :quantity_per_box, :quantity_of_box, vendor_ids: [])
  end
end
