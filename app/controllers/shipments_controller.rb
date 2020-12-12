class ShipmentsController < ApplicationController
  def index
  end

  def new
    if params[:commit] == "Search"
      if Category.find(params[:category_id])
        @products = Category.find(params[:category_id]).products
      else
        @products = []
      end
    else
      @products = []
    end
  end
end
