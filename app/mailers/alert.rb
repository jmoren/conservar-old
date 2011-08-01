class Alert < ActionMailer::Base
  default :from => "noreply@example.com"

  def send_alert(alert)
    @alert = alert
    @user = alert.user
    @item = alert.alertable
    email = @user.email
    mail(:to => email,:subject => "Notificacion Conservar")
  end

end
