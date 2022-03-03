class PostsController < ApplicationController
  before_action :update_interactions
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
    @comments = Comment.includes(:author).order(created_at: :asc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = Comment.includes(:author).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.text = params[:post][:text]
    @post.author_id = params[:user_id]
    if @post.save
      Post.update_post_count(User.find(current_user.id))
      flash[:success] = 'Post saved successfully'
      redirect_to user_posts_path(@post.author_id)
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :new, locals: { post: @post }
    end
  end

  def like
    user = User.find(params[:user_id])
    post = user.posts.find(params[:id])
    is_liked = Like.where(author_id: user, post_id: post).exists?
    if is_liked
      flash[:error] = 'Error: You already liked this post'
    else
      Like.create(author_id: user.id, post_id: post.id)
      flash[:success] = 'You liked this post'
    end
    redirect_to user_posts_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    post = user.posts.find(params[:id])
    if post.destroy
      Post.update_post_count(User.find(current_user.id))
      flash[:success] = 'Post deleted successfully'
    else
      flash[:error] = 'Opps! Somthing went wrong!'
    end
    redirect_to user_posts_path(user)
  end

  private

  def update_interactions
    @posts = Post.all
    @posts.each do |post|
      Comment.update_comments_counter(post)
      Like.update_likes_counter(post)
    end
  end
end
