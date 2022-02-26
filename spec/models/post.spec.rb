require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(id: 1, author_id: 1, title: 'First post', text: 'text sample', comments_counter: 1, likes_counter: 1)
  end

  before { subject.save }

  it 'title should not be more than 250 chars long' do
    subject.title = 'a' * 300
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be more or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be more or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should update users post count' do
    user = User.create(id: 1, name: 'Joe', photo: 'photo.url', bio: 'teacher from germany', posts_counter: 0)
    Post.create(id: 1, author_id: user.id, title: 'First post', text: 'text sample', comments_counter: 1,
                likes_counter: 1)
    Post.update_post_count(user)
    expect(user.posts_counter).to be(1)
  end

  it 'should return recent comments' do
    user = User.create(id: 1, name: 'Joe', photo: 'photo.url', bio: 'teacher from germany', posts_counter: 0)
    post = Post.create(author_id: user.id, title: 'First post', text: 'text sample', comments_counter: 1,
                       likes_counter: 1)
    Comment.create(author_id: user.id, post_id: post.id, text: 'New Comment')
    comments = Post.recent_comments(post)
    expect(comments.length).to be(1)
  end
end
