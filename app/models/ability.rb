# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.includes(:role).new(username: "guess", password: "guess", role_id: 5)

    can :manage, :all if user.admin?
    can %i[read create update], [Assignment, Form] if user.developer?
    can %i[read update], Form if user.tester?
    can :read, Assignment if user.tester?
    # cannot :create, Student if user.teacher?d
  end
end
