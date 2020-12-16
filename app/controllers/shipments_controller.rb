class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:update, :show, :destroy]

  def index
    @shipments = Shipment.all.order(:created_at)
  end

  def new
    if params.include? "category_id"
      if Category.find(params[:category_id])
        @products = Category.find(params[:category_id]).products
      else
        @products = []
      end
    else
      @products = []
    end
  end

  def create
    products = []
    params.each do |product|
      products << product
    end
    @shipment = Shipment.new(products: products[1..-4], is_received: false)
    if @shipment.save
      flash[:notice] = "shipment was created successfully"
      redirect_to @shipment
    else
      render "new"
    end
  end

  def update
    if @shipment.update(is_received: true)
      addProductQuantity(@shipment.products)
      flash[:notice] = "Data confirmed. Quantity has been updated"
      redirect_to @shipment
    else
      flash[:alert] = "Something went wrong"
      redirect_to shipments_path
    end
  end

  def show
  end

  def destroy
    if @shipment.is_received
      if @shipment.destroy
        flash[:notice] = "Shipment was deleted successfully"
        redirect_to shipments_path
      end
      # subtract quantity of products based on shipment.products
    else
      if @shipment.destroy
        flash[:notice] = "Shipment was deleted successfully"
        redirect_to shipments_path
      end
    end
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end

  def addProductQuantity(products)
    products.each do |product|
      findedProduct = Product.find(product[0])
      if findedProduct
        findedProduct.update(quantity_in_total: findedProduct.quantity_in_total.to_i + product[1].to_i)
      end
    end
  end
end
