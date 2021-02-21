class UsersController < ApplicationController
  before_action :redirect, only: [:edit, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @total_price = @posts.all.sum(:price)
    @total_calorie = @posts.all.sum(:calorie)
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = "入力内容をご確認ください"
      render :edit
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:user_update, keys: [:description, :nickname, :profile_photo])
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :description, :profile_photo)
  end

  def redirect
    redirect_to root_path if @user_id != current_user.id
  end

end
