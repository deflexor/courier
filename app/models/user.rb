class User < ActiveRecord::Base

  serialize :groups

  acts_as_authentic do |c|
    c.validate_email_field(false)
  end

  def is_admin?
    groups && groups.include?('admins')
  end

  def is_courier?
    groups && groups.include?('couriers')
  end

  def is_manager?
    groups && groups.include?('managers')
  end
end