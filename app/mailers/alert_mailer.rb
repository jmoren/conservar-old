class AlertMailer < ActionMailer::Base
  default :from => CONFIG['notification_mail']
  def send_alert(alert)
    @alert = alert
    @user = alert.user
    @item = alert.alertable
    @url = item_url(@item)
    email = @user.email
    mail(:to => email,:subject => "Notificacion Conservar")
  end

end

