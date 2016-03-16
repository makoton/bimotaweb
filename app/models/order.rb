# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base

  #relations
  belongs_to :user
  belongs_to :vehicle
  has_many :tasks
  has_many :comments

  before_create :generate_uuid
  before_save :update_last_change

  #constants
  STATUS_NEW = 'new'
  STATUS_INPROGRESS = 'inprogress'
  STATUS_FINISHED = 'finished'


  def self.select_status
    [['Nuevo', STATUS_NEW], ['En Progreso', STATUS_INPROGRESS], ['Finalizada', STATUS_FINISHED]]
  end

  def self.count_by_status(status)
    where(current_state: status).count
  end

  def start!(started_by_user)
    self.started_at = Time.now
    self.started_by = started_by_user.name
    self.current_state = STATUS_INPROGRESS
    self.save
  end

  def finish!(finished_by_user)
    self.finished_at = Time.now
    self.finished_by = finished_by_user.name
    self.current_state = STATUS_FINISHED
    self.tasks.each do |task|
      task.finish!
    end
    self.save
  end

  def update_last_change
    self.last_update = Time.now
  end

  private

  def generate_uuid
    self.uuid = Digest::SHA1.hexdigest("bimota-id-#{Time.zone.now.to_f.to_s}")[8..16].upcase
  end
end