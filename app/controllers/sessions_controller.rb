class SessionsController < ApplicationController
  before_filter :check_logged_in,  :except => [:new, :create]
  before_filter :check_logged_out, :except => [:destroy]

  layout false

  def new
    @user_session = UserSession.new
    render :json => { :template => render_to_string("sessions/new") }
  end

  def create

  end
end