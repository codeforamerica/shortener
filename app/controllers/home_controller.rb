class HomeController < ApiController
  def index
    if Rails.application.secrets.shortener_root_redirect_url.present?
      redirect_to Rails.application.secrets.shortener_root_redirect_url
    else
      render plain: "Shortener"
    end
  end
end
