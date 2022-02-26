require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Joe', photo: 'photo.url', bio: 'teacher from germany', posts_counter: 1) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be more or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'recent_posts method should return 0 posts' do
    posts = User.recent_posts(subject)
    expect(posts.length).to be(0)
  end
end
