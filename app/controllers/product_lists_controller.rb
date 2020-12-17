require "csv"

class ProductListsController < ApplicationController
  before_action :set_productList, only: [:udpate, :show, :destroy]

  def index
    @product_lists = ProductList.all
  end

  def new
    @product_list = ProductList.new
  end

  def create
    productsArray = parseCSVFileToArray(product_list_params[:data])
    @product_list = ProductList.new(products: productsArray)
    if @product_list.save
      flash[:notice] = "Product data was uploaded successfully"
      redirect_to @product_list
    else
      render "new"
    end
  end

  def show
  end

  def update
    @productList = ProductList.find(params[:id])
    createProducts(@productList)
    redirect_to product_lists_path
  end

  def destroy
    if @product_list.destroy
      flash[:notice] = "Successfully"
      redirect_to product_lists_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to(:back)
    end
  end

  private

  def set_productList
    @productList = ProductList.find(params[:id])
  end

  def product_list_params
    params.require(:product_list).permit(:data)
  end

  def parseCSVFileToArray(csv)
    CSV.parse(csv.read)
  end

  def createProducts(productList)
    errors = []
    productList.products.each do |product|
      name = product[0]
      foreign_name = product[1]
      barcode = nil
      category_id = Category.find_or_create_by(name: product[2])
      quantity_in_total = nil

      newProduct = Product.new(name: name, foreign_name: foreign_name, expiration_date: Time.new(2000, 1, 1), barcode: barcode.to_s, category_id: category_id.id, quantity_in_total: quantity_in_total.to_i)

      if newProduct.save
        p "product is created successfully"
      else
        newProduct.update(category_id: 0)
        erros.push(newProduct.name + ":" + newProduct.errors.full_messages.to_s)
      end
    end
  end
end
