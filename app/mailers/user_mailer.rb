class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @activation_url = "#{ root_url }users/#{ user.activation_token }/activate"
    mail to: user.email,
         subject: 'Welcome on Lessy!'
  end

  def activation_success_email(user)
    @user = user
    mail to: user.email,
         subject: 'Your account is now activated'
  end
end
