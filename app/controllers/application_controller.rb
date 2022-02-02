# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user
  before_filter :mailer_set_url_options

  private

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  #  def current_user
  #    @current_user ||= session[:user_id]
  #  end

  def require_user
    unless current_user
      session[:return_to] = request.request_uri
      flash[:notice] = "Страница требует авторизации."
      redirect_to new_session_url
      return false
    end
  end
  def require_admin_user
    unless current_user && current_user.is_admin?
      flash[:notice] = "Недостаточно прав."
      redirect_to request.env['HTTP_REFERER']
      return false
    end
  end
  def require_manager_user
    unless current_user && current_user.is_manager?
      flash[:notice] = "Недостаточно прав."
      redirect_to request.env['HTTP_REFERER']
      return false
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
