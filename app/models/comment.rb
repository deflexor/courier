class Comment < ActiveRecord::Base
  validates_presence_of :author, :body
  belongs_to :courier_task
  after_create :deliver_mail_to

  private
  def deliver_mail_to
    if author == courier_task.manager
      deliver_to_courier
    else
      deliver_to_manager
    end
  end

  def deliver_to_courier
    courier_task.courier && courier_task.courier.email &&
      CourierMailer.deliver_new_comment(courier_task.courier.email,courier_task, self)
  end

  def deliver_to_manager
    courier_task.manager && courier_task.manager.email &&
      CourierMailer.deliver_new_comment(courier_task.manager.email, courier_task, self)
  end
end
