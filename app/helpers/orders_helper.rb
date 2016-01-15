# -*- encoding : utf-8 -*-
module OrdersHelper

  def status_for(order)
    case order.current_state
      when 'new'
        'Nuevo'
      when 'inprogress'
        'En Progreso'
      when 'finished'
        'Finalizado'
      else
        'Nuevo*'
    end
  end
end