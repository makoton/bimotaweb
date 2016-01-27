# -*- encoding : utf-8 -*-
module OrdersHelper

  def status_for(order)
    case order.current_state
      when 'new'
        '<span class="label label-primary">Nuevo</span>'.html_safe
      when 'inprogress'
        '<span class="label label-warning">En Progreso</span>'.html_safe
      when 'finished'
        '<span class="label label-success">Finalizado</span>'.html_safe
      else
        'Nuevo*'
    end
  end

  def money_for(amount)
    number_to_currency(amount.to_i, unit: '$', delimiter: '.', format: '%u %n')
  end
end