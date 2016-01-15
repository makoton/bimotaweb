# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base

  #relations
  belongs_to :user
  belongs_to :vehicle

  before_create :generate_uuid


  #constants


  private

  def generate_uuid
    self.uuid = Digest::SHA1.hexdigest("bimota-id-#{Time.zone.now.to_f.to_s}")[8..16].upcase
  end
end