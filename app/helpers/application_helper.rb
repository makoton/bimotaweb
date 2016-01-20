module ApplicationHelper
  def format_rut_for(user)
    user.user_information.rut if user.user_information
  end
end
