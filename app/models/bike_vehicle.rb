# -*- encoding : utf-8 -*-
class BikeVehicle < Vehicle

  def dissociate
    self.user_id = nil
    self.save
  end
end