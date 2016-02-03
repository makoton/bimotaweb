class AddUnavailableSuppliesCountToSupplies < ActiveRecord::Migration

  def self.up

    add_column :supplies, :unavailable_supplies_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :supplies, :unavailable_supplies_count

  end

end
