class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @total_price = @posts.all.sum(:price)
    @total_calorie = @posts.all.sum(:calorie)
  end

end
