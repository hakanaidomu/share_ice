class UsersController < ApplicationController
  before_action :redirect, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @total_price = @posts.all.sum(:price)
    @total_calorie = @posts.all.sum(:calorie)
  end

  def redirect
    redirect_to root_path if @user_id != current_user.id
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        render :edit
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end   
    else
        redirect_to root_url
    end
  end
end
