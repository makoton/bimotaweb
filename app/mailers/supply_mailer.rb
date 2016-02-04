# -*- encoding : utf-8 -*-
class SupplyMailer < ActionMailer::Base
  default from: 'notifications@bimota.cl'

  def low_stock(email, supply)
    @supply = supply

    host = if Rails.env == 'production'
             'https://nameless-cove-87877.herokuapp.com/admin/'
           else #development
             'http://0.0.0.0:3000/admin/'
           end
    @url = if supply.is_a?(PartSupply)
             host + "part_supplies/#{supply.id}"
           else #consumable supply
             host + "consumable_supplies/#{supply.id}"
           end
    @type = @supply.is_a?(PartSupply) ? 'Repuesto' : 'Insumo'

    mail(to: email, subject: "[BimotaWeb] Stock bajo para #{@supply.title} [#{@type}")
  end

end