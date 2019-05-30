class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.admin?
      can :manage, all
    end

    can :manage, Trip, user_id: user.id
  end
end
