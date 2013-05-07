class InvitesController < ApplicationController
  before_filter :check_logged_in, :except => [:accept, :show]
  before_filter :init_invite,     :only   => [:show, :accept]

  layout false, :except => [:show, :accept]

  def new
    @invite = current_user.invites.build
    render :json => { :template => render_to_string("invites/new") }
  end

  def create
    @invite = current_user.invites.build(params[:invite])

    if @invite.save
      render :json => { :completed => true, :url => root_url }
    else
      render :json => { :completed => false, :templates => render_to_string(:partial => "invites/form") }
    end
  end

  def accept
    @invite.assign_attributes(params[:invite])
    if @invite.valid?
      user = User.new(:username => @invite.username,
                  :email    => @invite.email,
                  :password => @invite.password
      )
      user.blog = @invite.user.blog
      user.save!

      log_in(user)
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def init_invite
    @invite = Invite.by_token(params[:id]).first
    @user   = @invite.user

    unless (user = User.by_email(@invite.email).first).nil?
      user.blog = @invite.user.blog
      user.save!

      redirect_to root_path
    end
  end
end