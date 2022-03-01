class UsersController < ApplicationController
  before_action :update_interactions
  before_action :authenticate_user!

  def index
    @users = User.all.order(id: :asc)
  end

  def show
    @user = User.find(params[:id])
    @posts = User.recent_posts(@user)
  end

  private

  def update_interactions
    @users = User.all
    @users.each do |user|
      Post.update_post_count(user)
    end
  end
end
