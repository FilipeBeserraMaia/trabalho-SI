class BrasilApi
  require 'rest-client'
  require 'json'

  def self.fetch(url)
    RestClient.get(url)
  end

  def self.get_data(response)
    JSON.parse(response.body) if response.code.to_i == 200
  end

  def self.get_estados
    url = "https://brasilapi.com.br/api/ibge/uf/v1"
    resp = fetch(url)
    get_data(resp)
  end

  def self.get_municipios(sigla_uf)
    url = "https://brasilapi.com.br/api/ibge/municipios/v1/#{sigla_uf}"
    resp = fetch(url)
    get_data(resp)
  end

  def self.get_cep(cep)
    url = "https://brasilapi.com.br/api/cep/v1/#{cep}"
    resp = fetch(url)
    get_data(resp)
  end

end