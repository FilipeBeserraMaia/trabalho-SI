class MunicipeMailer < ApplicationMailer

  def new_municipe_email
    @default_exclude_attrs = [:updated_at, :id, :created_at]
    @municipe = params[:municipe]
    @attributes = params[:attributes]
    mail(to: @municipe.email, subject: 'Seu cadastro foi efetuado com sucesso')
  end

  def update_municipe_email
    @default_exclude_attrs = [:updated_at, :id, :created_at]
    @municipe = params[:municipe]
    @changes = params[:changes]
    mail(to: @municipe.email, subject: 'Atualização de dados cadastrais')
  end

end