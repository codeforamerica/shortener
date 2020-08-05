class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html { render plain: "Shortener" }
      format.js { render json: { message: "Shortener" } }
    end
  end
end
