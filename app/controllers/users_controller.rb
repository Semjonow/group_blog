class UsersController < ApplicationController
  before_filter :check_logged_out
  layout false

  def new
    @user = User.new
    render :json => { :template => render_to_string("users/new") }
  end

  def create

  end
end