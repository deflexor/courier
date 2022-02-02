class CourierTask < ActiveRecord::Base
  validates_presence_of :manager, :status, :client_address
  has_many :comments, :order => 'created_at DESC'
  belongs_to :manager, :class_name => 'User'
  belongs_to :courier, :class_name => 'User'

  validates_length_of :client_phone, :maximum => 32
  validates_length_of :status, :maximum => 16


  after_create do |task|
    CourierMailer.deliver_new_task(task)
  end
  after_update do |task|
    #CourierMailer.deliver_finished_task(task) if task.status == 'finished' && task.courier && task.courier.email
    CourierMailer.deliver_accepted_task(task) if task.status == 'accepted' && task.courier && task.courier.email
    CourierMailer.deliver_completed_task(task) if task.status == 'complete' && task.courier && task.courier.email
  end

end
