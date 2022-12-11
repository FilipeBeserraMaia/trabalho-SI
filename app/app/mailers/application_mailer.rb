class ApplicationMailer < ActionMailer::Base
  # default from: "filipe.maia@academico.ifg.edu.br"
  default from: "filipeifgcc@gmail.com"
  layout "mailer"

  def erro_500_mail
    @exceptionn = params[:exception]
    dev = 'filipeifgcc@gmail.com'
    mail(to: dev, subject: 'Houve um Erro na aplicação - 500 !!! ')
  end
end