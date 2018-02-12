# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    UserMailerMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailerMailer.password_reset
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/email_notification
  def email_notification
    UserMailerMailer.email_notification
  end

end
