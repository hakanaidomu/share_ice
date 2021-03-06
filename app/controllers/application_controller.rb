class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

private
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:description, :nickname, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:description, :nickname, :image])
  end

  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result.order(created_at: :desc).page(params[:page]).per(10)
  end
end
