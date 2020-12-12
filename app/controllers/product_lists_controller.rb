require "csv"

class ProductListsController < ApplicationController
  def index
    @product_lists = ProductList.all
  end

  def new
    @product_list = ProductList.new
  end

  def create
    #Parse csv file to array
    parsed = CSV.parse(product_list_params[:data].read)
    date = product_list_params[:date]
    @product_list = ProductList.new(products: parsed)
    if @product_list.save
      flash[:notice] = "Product data was uploaded successfully"
      redirect_to @product_list
    else
      render "new"
    end
  end

  def show
    @product_list = ProductList.find(params[:id])
  end

  def update
    @product_list = ProductList.find(params[:id])
    @errors = []
    if true
      @product_list.products.each do |product|
        name = product[0]
        foreign_name = product[1]
        barcode = nil
        quantity_in_total = nil
        category_id = Category.find_or_create_by(name: product[2])

        newProduct = Product.new(name: name, foreign_name: foreign_name, expiration_date: Time.new(2000, 1, 1), barcode: barcode.to_s, category_id: category_id.id, quantity_in_total: quantity_in_total)

        if newProduct.save
          p "product is created successfully"
        else
          newProduct.update(category_id: 0)
          p "something went wrong: " + newProduct.errors.full_messages.to_s
        end
      end
      flash[:notice] = @errors

      redirect_to products_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to product_lists_path
    end
  end

  def destroy
    @product_list = ProductList.find(params[:id])
    if @product_list.destroy
      flash[:notice] = "Successfully"
      redirect_to product_lists_path
    else
      flash[:alert] = "Soemthing went wrong"
      redirect_to(:back)
    end
  end

  private

  def product_list_params
    params.require(:product_list).permit(:data)
  end

  def cvsFormator(format)
    if format.to_s == "backend"
    end
  end
end
