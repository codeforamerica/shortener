class LinksController < ApiController
  before_action :verify_api_key, only: [:create, :show]

  def show
    @link = Link.find_by(slug: params[:slug])

    if @link
      render json: @link.to_hash(self)
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  def create
    @link = Link.new
    @link.assign_attributes(link_attributes)

    if @link.save
      render json: @link.to_hash(self), status: :created
    else
      render json: { error: @link.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def redirect
    @link = Link.find_by(slug: params[:slug])
    if @link.present?
      link_use = @link.uses.create(ip_address: request.remote_ip, user_agent: request.user_agent)
      @link.first_used_at = link_use.created_at if @link.first_used_at.blank?
      @link.last_used_at = link_use.created_at
      @link.save!

      redirect_to @link.url, status: :found
    else
      render plain: "Sorry, the URL you requested could not be found", status: :not_found
    end
  end

  private

  def link_attributes
    params.permit(:url, :description)
  end

  def verify_api_key
    return if params[:api_key] == Rails.application.secrets.shortener_api_key

    render json: { error: "Invalid API Key" }, status: :unauthorized
  end
end
