require "csv"

class SalesController < ApplicationController
  before_action :set_sale, only: [:update, :show, :destroy]

  @@addSale = "addSale"
  @@deleteSale = "deleteSale"

  def index
    @sales = Sale.all.order(:date)
  end

  def new
    @sale = Sale.new
  end

  def create
    saleData = parseCSVFileToArray(sales_params[:data])
    saleDate = sales_params[:date]
    @sale = Sale.new(date: saleDate, data: saleData)
    if @sale.save
      flash[:notice] = "Sale data was uploaded successfully"
      redirect_to @sale
    else
      render "new"
    end
  end

  def show
  end

  def update
    if !@sale.is_confirm
      @sale.update(is_confirm: true)
      updateProductsQuantity(@sale, @@addSale)
      flash[:notice] = "Data confirmed. Quantity had been updated"
      redirect_to @sale
    else
      updateProductsQuantity(@sale, @@deleteSale)
      redirect_to sales_path
    end
  end

  def destroy
    if @sale.is_confirm
      if @sale.destroy
        updateProductsQuantity(@sale, @@deleteSale)
        flash[:notice] = "Sale was deleted successfully"
        redirect_to sales_path
      else
        flash[:alert] = "Something went wrong"
        redirect_to(:back)
      end
    else
      if @sale.destroy
        flash[:notice] = "Sale was deleted successfully"
        redirect_to sales_path
      else
        flash[:alert] = "Something went wrong"
        redirect_to(:back)
      end
    end
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sales_params
    params.require(:sale).permit(:date, :data)
  end

  def parseCSVFileToArray(csv)
    CSV.parse(csv.read).drop(1)
  end

  def addInstanceId(product, instancd_id)
    if product.instance_id.nil?
      product.update(instance_id: instancd_id)
    end
  end

  def updateProductsQuantity(sale, type)
    if type == @@addSale
      sale.data.each do |product|
        findedProduct = Product.find_by(name: product[2])
        if findedProduct
          addInstanceId(findedProduct, product[0])
          findedProduct.update(quantity_in_total: findedProduct.quantity_in_total - product[4].to_i)
        end
      end
    elsif type == @@deleteSale
      sale.data.each do |product|
        finded = Product.find_by(name: product[2])
        if finded
          finded.update(quantity_in_total: finded.quantity_in_total + product[4].to_i)
        end
      end
    else
    end
  end
end
