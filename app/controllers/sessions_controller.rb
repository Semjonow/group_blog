class SessionsController < ApplicationController
  before_filter :check_logged_in,  :except => [:new, :create]
  before_filter :check_logged_out, :except => [:destroy]

  layout false

  def new
    @user_session = UserSession.new
    render :json => { :template => render_to_string("sessions/new") }
  end

  def create
    @user_session = log_in(params[:user_session])

    if logged_in?
      render :json => { :completed => true, :url => back_or_default(root_url) }
    else
      render :json => { :completed => false, :template => render_to_string(:partial => "sessions/form") }
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_path
  end
end