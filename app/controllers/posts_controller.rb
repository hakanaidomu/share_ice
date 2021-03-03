class PostsController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :redirect, only: [:edit, :update, :destroy]
  
  def index
      @randams = Post.order("RAND()").limit(10)
    @tags = Post.tag_counts_on(:tags).most_used(20)
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).page(params[:page]).per(6)
      @randams = Post.tagged_with(params[:tag]).order("RAND()").limit(5)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(6)
    end
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
    @comment = Comment.new
    @comments = @post.comments
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

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private 
  def post_params
    params.require(:post).permit(:image, :content, :calorie, :price, :tag_list).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def redirect
    redirect_to root_path if @post.user_id != current_user.id
  end
  
end
