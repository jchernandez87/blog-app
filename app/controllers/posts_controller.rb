class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
    @comments = Comment.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = Comment.order(created_at: :desc)
  end
end
