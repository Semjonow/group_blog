class Mailer < ActionMailer::Base
  default :from => "team@sexmash.in"

  def invite(user_id, invite_id)
    @user   = User.find(user_id)
    @invite = @user.invites.find(invite_id)

    mail(
        :to => @invite.email,
        :subject => "New invitation from #{@user.username}",
        :tag => "invite"
    )
  end
end
