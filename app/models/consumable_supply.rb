# -*- encoding : utf-8 -*-
class ConsumableSupply < Supply

  validates_uniqueness_of :category, case_sensitive: false

end