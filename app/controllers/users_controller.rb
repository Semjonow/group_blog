class UsersController < ApplicationController
  before_filter :check_logged_out
  layout false

  def new
    @user = User.new
    render :json => { :template => render_to_string("users/new") }
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in(@user)
      render :json => { :completed => true, :url => root_url }
    else
      render :json => { :completed => false, :template => render_to_string(:partial => "users/form") }
    end
  end
end