class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_search
  add_flash_types :success, :info, :warning, :danger
private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:description, :nickname, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:description, :nickname, :image])
  end

  # def set_search
  #   @search = Post.ransack(params[:q])
  #   @search_posts = @search.result.order(created_at: :desc).page(params[:page]).per(10)
  # end
end
