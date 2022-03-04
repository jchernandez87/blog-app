class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id

    return unless user.is? :admin

    can :manage, :all
  end
end
