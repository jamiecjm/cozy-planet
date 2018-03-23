class Ability
  include CanCan::Ability

  def initialize(current_user)
	if current_user.present?
		can :read, ActiveAdmin::Page
		can [:read, :update], current_user
		can :create, ActiveAdmin::Comment
		if current_user.owner?
			can [:read], Unit, owner_id: current_user.id
			can [:read], Booking, unit: {owner_id: current_user.id}
		elsif current_user.operator?
			can :manage, Unit
			can :manage, Booking
		elsif current_user.admin?
			can :manage, :all
		end
	end

  end

end