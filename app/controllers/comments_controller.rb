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
      redirect_to user_post_path(id: params[:post_id], user_id: params[:user_id])
    else
      render :new
    end
  end
end
