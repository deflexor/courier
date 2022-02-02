class SessionsController < ApplicationController

  def new
  end

  def create
    @openid_url = APP_CONFIG['oid_provider'] + params[:login] if params[:login]
    #logger.debug "%s" % @openid_url
    open_id_authentication
  end

  def destroy
    #session[:user_id] = nil
    current_user_session.destroy
    redirect_to new_session_url
  end


  protected

  def open_id_authentication
    authenticate_with_open_id @openid_url, :required => [:country, :nickname, :email] do |result, identity_url, sreg|
      if result.successful?
        if URI.parse(identity_url).host != URI.parse(APP_CONFIG['oid_provider']).host
          failed_login "wrong oid host"
          return
        end
        @current_user = User.find_or_initialize_by_login(sreg['nickname'])
        @current_user.email = sreg['email']
        # use sreg 'country' field for goups info (admin,manager,courier)
        groups = sreg['country'] ? sreg['country'].split(',') : []
        @current_user.groups = groups
        @current_user.save!
        successful_login
      else
        #failed_login result.message
        failed_login "Данный аккаунт не может быть авторизован."
      end
    end
  end


  private
  def successful_login
    #session[:user_id] = @current_user.login
    UserSession.create(@current_user)
    redirect_back_or_default root_url
    #redirect_to(root_url)
  end

  def failed_login(message)
    flash[:error] = message
    redirect_to(new_session_url)
  end

end
