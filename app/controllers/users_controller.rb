class UsersController < ApplicationController
  before_action :redirect, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(6)
    @total_posts = @user.posts
    @total_price = @total_posts.all.sum(:price)
    @total_calorie = @total_posts.all.sum(:calorie)
    from  = 1.week.ago.at_beginning_of_day
    to    = (from + 6.day).at_end_of_day
    
    
    @week_post = @user.posts.where(created_at: from...to)
    @week_price = @week_post.all.sum(:price)
    @week_calorie = @week_post.all.sum(:calorie)
    @data = @user.posts
  end

  private

  def redirect
    redirect_to root_path if @user_id != current_user.id
  end

end
