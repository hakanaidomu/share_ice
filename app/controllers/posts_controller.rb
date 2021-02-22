class PostsController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :redirect, only: [:edit, :update, :destroy]
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    if @post.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private 
  def post_params
    params.require(:post).permit(:image, :content, :calorie, :price).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def redirect
    redirect_to root_path if @post.user_id != current_user.id
  end

end
