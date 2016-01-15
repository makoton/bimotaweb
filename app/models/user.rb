# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

  has_and_belongs_to_many :roles

  has_many :bike_vehicles
  has_many :orders
  has_one :user_information

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, invite_for: 2.weeks

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  def role?(role)
    !!self.roles.find_by_name(role.to_s)
  end

  
end
