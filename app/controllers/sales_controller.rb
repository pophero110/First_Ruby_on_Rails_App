require "csv"

class SalesController < ApplicationController
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    #Parse csv file to array
    parsed = CSV.parse(sales_params[:data].read).drop(1)
    date = sales_params[:date]
    @sale = Sale.new(date: date, data: parsed)
    if @sale.save
      flash[:notice] = "Sale data was uploaded successfully"
      redirect_to @sale
    else
      render "new"
    end
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(is_confirm: true)
      #update product quantity based on sale data
      @sale.data.each do |product|
        finded = Product.find_by(name: product[2])
        if finded
          finded.update(quantity_in_total: finded.quantity_in_total - product[4].to_i)
        end
      end
      flash[:notice] = "Data confirmed. Quantity had been updated"
      redirect_to @sale
    else
      flash[:alert] = "Something went wrong"
      redirect_to
    end
  end

  private

  def sales_params
    params.require(:sale).permit(:date, :data)
  end
end
