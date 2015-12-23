# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :mechanic
      can :manage, [Order, Service]
    elsif user.role? :operator
      can :manage, [Order, Client, Vehicle, BikeVehicle]
      can :read, [Supply, PartSupply, ConsumableSupply]
    end
  end
end
