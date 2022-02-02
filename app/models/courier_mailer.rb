require 'net/http'

class CourierMailer < ActionMailer::Base

  SubjTmpl = 'Внутренний интерфейс WM: %s'
  From = 'dfr@wm.ru'

  def fetch_couriers
    users = RemoteUser.get :list_by_group, :g => 'couriers'
    emails = users.map { |u| u['email'] }.compact
    #logger.debug "users: #{users.inspect} emails: #{emails.join(',')}"
    emails
  end

  def new_task(task)
    subject    SubjTmpl % 'Новая поездка'
    recipients fetch_couriers
    from       From
    sent_on    Time.now
    body       :task => task
  end

  def deleted_task(task)
    subject    SubjTmpl % 'Новая поездка удалена'
    recipients fetch_couriers
    from       From
    sent_on    Time.now
    body       :task => task
  end

  def new_comment(to, task, comment)
    subject    SubjTmpl % 'К  поездке добавлен комментарий'
    recipients to
    from       From
    sent_on    Time.now
    
    body       :task => task, :comment => comment
  end

  def accepted_task(task)
    subject    SubjTmpl % 'Новая поездка получена курьером.'
    recipients task.manager.email
    from       From
    sent_on    Time.now
    body       :task => task
  end

  def completed_task(task)
    subject    SubjTmpl % 'Поездка выполнена курьером'
    recipients task.manager.email
    from       From
    sent_on    Time.now
    body       :task => task
  end

  def finished_task(task)
    subject    SubjTmpl % 'Задание завершено'
    recipients task.courier.email
    from       From
    sent_on    Time.now
    
    body       :task => task
  end

end
