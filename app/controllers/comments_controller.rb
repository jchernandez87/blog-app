class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new
    @comment.text = params[:comment][:text]
    @comment.author_id = params[:user_id]
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_posts_path(user_id: params[:user_id])
    else
      flash.now[:error] = 'Error: Comment could not be create'
      render :new
    end
  end
end
