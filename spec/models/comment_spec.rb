require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'Should update post comments_counter value' do
    user = User.create(id: 1, name: 'Joe', photo: 'url', bio: 'teacher from germany', posts_counter: 1)
    post = Post.create(id: 1, author_id: user.id, title: 'New Post', text: 'post text', comments_counter: 0,
                       likes_counter: 1)
    Comment.create(author_id: user.id, post_id: post.id, text: 'First Comment')
    Comment.update_comments_counter(post)
    expect(post.comments_counter).to be(0)
  end
end
