class UsersController < ApplicationController
  before_action :redirect, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @total_price = @posts.all.sum(:price)
    @total_calorie = @posts.all.sum(:calorie)
  end

  private

  def redirect
    redirect_to root_path if @user_id != current_user.id
  end

end
