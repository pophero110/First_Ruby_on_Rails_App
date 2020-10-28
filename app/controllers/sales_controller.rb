require "csv"

class SalesController < ApplicationController
  def index
    @sales = [[]]
    Sale.all.each do |sale|
      # puts sale.data
      path = Rails.root.join("public", "sales", sale.data)
      # puts path
      readed = File.read(path)

      file = CSV.parse(readed).drop(1)

      @sales.first << sale.date
      @sales << []

      file.each_with_index do |product, index|
        @sales.last << [file[index][2], file[index][3], file[index][4]]
      end
    end
    puts @sales
    # Sale.all.each do |sale|
    #
    # end
  end

  def new
    @sale = Sale.new
  end

  def create
    readed = sales_params[:data].read
    uploaded_file = sales_params[:data]
    File.open(Rails.root.join("public", "sales", uploaded_file.original_filename), "wb") do |file|
      file.write(readed)
    end
    parsedProducts = CSV.parse(readed)
    puts parsedProducts.drop(1)
    parsedProducts.drop(1).each do |product|
      finded = Product.find_by(name: product[2])
      puts finded.quantity_in_total
      puts product.last
    end

    @sale = Sale.new(date: sales_params[:date], data: sales_params[:data].original_filename)
    if @sale.save
      flash[:notice] = "Sale was created successfully."
      redirect_to sales_path
    else
      render "new"
    end
  end

  private

  def sales_params
    params.require(:sale).permit(:date, :data)
  end
end
