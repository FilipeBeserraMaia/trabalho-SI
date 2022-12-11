class BrasilApiController < ApplicationController

  def estados
    render json: BrasilApi.get_estados
  end

  def municipios
    render json: BrasilApi.get_municipios(params[:sigla_uf])
  end

  def cep
    render json: BrasilApi.get_cep(params[:cep])
  end

end
