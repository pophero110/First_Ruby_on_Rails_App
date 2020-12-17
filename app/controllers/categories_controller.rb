class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all.order(:name)
  end

  def show
    @category = Category.find(params[:id])

    @products = @category.products.order(:updated_at).reverse_order
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category name updated successfully"
      redirect_to @category
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = @category.name.to_s + "was deleted successfully"
      redirect_to categories_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to(:back)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admin can perform that action"
      redirect_to categories_path
    end
  end
end
