class ApplicationMailer < ActionMailer::Base

  default from: 'noreply@lessy.io'
  layout 'mailer'

protected

  def mail(options={})
    options[:subject] = "[Lessy] #{ options[:subject] }" if options.has_key? :subject
    super options
  end

end
