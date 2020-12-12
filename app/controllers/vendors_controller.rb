class VendorsController < ApplicationController
  def index
    @vendors = Vendor.all.order(name: :desc)
  end

  def new
    @vendor = Vendor.new()
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      flash[:notice] = "vendor was created successfully."
      redirect_to @vendor
    else
      render "new"
    end
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :email, :contact_number, :address, :language_preference)
  end
end
