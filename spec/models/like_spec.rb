require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'Should update post likes_counter value' do
    user = User.create(id: 1, name: 'Joe', photo: 'url', bio: 'teacher from germany', posts_counter: 1)
    post = Post.create(id: 1, author_id: user.id, title: 'New Post', text: 'post text', comments_counter: 0,
                       likes_counter: 0)
    Like.create(author_id: user.id, post_id: post.id)
    Like.update_likes_counter(post)
    expect(post.likes_counter).to be(0)
  end
end
