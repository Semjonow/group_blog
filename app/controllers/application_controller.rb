class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session
  helper_method :current_user
  helper_method :logged_in?

  def check_logged_in
    unless logged_in?
      store_location
      redirect_to root_path
    end
  end

  def check_logged_out
    if logged_in?
      redirect_to root_path
    end
  end

  def log_out
    return current_user_session.destroy if logged_in?
    false
  end

  def log_in(user)
    log_out
    UserSession.create(user, user.respond_to?("remember_me?") && user.remember_me? ? true : false)
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def logged_in?
    current_user.present?
  end

  protected

  def back_or_default(default)
    ((session[:return_to] || params[:return_to]) || default).tap do
      session.delete(:return_to)
    end
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.json { head :not_found }
    end
  end

  private

  def store_location
    session[:return_to] = "#{root_url}#{request.blank? ? '' : request.fullpath[1,request.fullpath.length]}" if request.get? && !request.xhr?
  end

  def current_user_session
    @current_user_session ||= UserSession.find
  end
end
