# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :create, Comment
    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id
    return unless user.admin?

    can :manage, Post
    can :manage, Comment
  end
end
