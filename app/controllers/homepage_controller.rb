class HomepageController < ApplicationController
  def index
    if params[:error]
      if params[:barcode]
        @barcode = params[:barcode]
      end
    end
  end

  private
end
