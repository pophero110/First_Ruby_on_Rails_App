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
    if @sale.update(is_confirm: true)
      updateProductsQuantity(@sale, @@addSale)
      flash[:notice] = "Data confirmed. Quantity had been updated"
      redirect_to @sale
    else
      flash[:alert] = "Something went wrong"
      redirect_to sales_path
    end
  end

  def destroy
    if @sale.destroy
      updateProductsQuantity(@sale, @@deleteSale)
    else
      flash[:alert] = "Soemthing went wrong"
      redirect_to(:back)
    end
    redirect_to sales_path
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

  def updateProductsQuantity(sale, type)
    if type == @@addSale
      sale.data.each do |product|
        findedProduct = Product.find_by(name: product[2])
        if findedProduct
          findedProduct.update(quantity_in_total: finded.quantity_in_total - product[4].to_i)
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
