class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :asc)
    @users.each do |user|
      Post.update_post_count(user)
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = User.recent_posts(@user)
  end
end
