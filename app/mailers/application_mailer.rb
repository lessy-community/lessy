class ApplicationMailer < ActionMailer::Base

  default from: 'noreply@projectzero.org'
  layout 'mailer'

protected

  def mail(options={})
    options[:subject] = "[Project Zero] #{ options[:subject] }" if options.has_key? :subject
    super options
  end

end
