class EnderecosController < ApplicationController
  before_action :set_endereco, only: %i[ show edit update destroy ]

  # GET /enderecos or /enderecos.json
  def index
    set_enderecos()
  end

  def search
    set_enderecos()
    if params[:term].present?
      @enderecos = @enderecos.like(params[:term])
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enderecos()
    @enderecos = Endereco.all
  end

  def set_endereco()
    @endereco = Endereco.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def endereco_params
    params.require(:endereco).permit(:id, :cep, :longr, :complemento, :bairro, :cidade, :uf, :cdg_ibge, :municipe_id)
  end

end
