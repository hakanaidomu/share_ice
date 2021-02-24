class Posts::SearchesController < ApplicationController
  def index
    @posts = Posts.search(params[:keyword])
  end
end