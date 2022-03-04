require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(id: 1, name: 'Joe', bio: 'teacher from germany', posts_counter: 0)
    @post = Post.create(id: 1, author_id: @user.id, title: 'First post', text: 'text sample', comments_counter: 0,
                        likes_counter: 0)
  end

  it 'title should not be more than 250 chars long' do
    @post.title = 'a' * 300
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    @post.comments_counter = 'string'
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be more or equal to 0' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    @post.likes_counter = 'string'
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be more or equal to 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  it 'should update users post count' do
    Post.update_post_count(@user)
    expect(@user.posts_counter).to be(0)
  end

  it 'should return recent comments' do
    Comment.create(author_id: @user.id, post_id: @post.id, text: 'New Comment')
    comments = Post.recent_comments(@post)
    expect(comments.length).to be(0)
  end
end
