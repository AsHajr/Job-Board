# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Job, :all
    can :manage, Job, :created_by => user.id.to_s
  end
end
