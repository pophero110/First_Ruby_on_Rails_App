class ProductListsController < ApplicationController
  def index
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
    if true
      @product_list.products.each do |product|
        name = product[0]
        foreign_name = product[1]
        barcode = product[2] || 1234567890123
        quantity_in_total = product[3] || 0
        quantity_per_box = product[4] || 0
        category_id = Category.find_by(name: product[5]).id || 1

        newProduct = Product.new(name: name, foreign_name: foreign_name, expiration_date: Time.new(2000, 1, 1), barcode: barcode.to_s, category_id: category_id, quantity_in_total: quantity_in_total, quantity_per_box: quantity_per_box, quantity_of_box: 0)
        newProduct.save
      end
      flash[:notice] = "Data confirmed. Products had been uploaded"
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
end
