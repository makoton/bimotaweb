# -*- encoding : utf-8 -*-
module OrdersHelper

  def status_for(obj)
    status = obj.respond_to?(:current_state) ? obj.current_state : obj.status

    case status
      when 'new'
        '<span class="label label-primary">Nuevo</span>'.html_safe
      when 'inprogress', 'pending'
        '<span class="label label-warning">En Progreso</span>'.html_safe
      when 'finished'
        '<span class="label label-success">Finalizado</span>'.html_safe
      else
        'Nuevo*'
    end
  end

  def money_for(amount)
    number_to_currency(amount.to_i, unit: '$', delimiter: '.', format: '%u %n', precision: 0)
  end
end