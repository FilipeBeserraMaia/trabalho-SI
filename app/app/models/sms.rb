class Sms
  attr_reader :message, :number, :default_exclude_attrs, :type

  def initialize(message, number, type)
    @default_exclude_attrs = [:updated_at, :id, :created_at]
    @message = if type == :create
                 format_create_message(message)
               else
                 format_update_message(message)
               end
    @number = number
    @type = type
  end

  def call
    if TWILIO_SENDER_NUMBER.present?
      client = Twilio::REST::Client.new
      client.messages.create({
                               from: TWILIO_SENDER_NUMBER,
                               to: @number,
                               body: @message
                             })
    end
  end

  def format_update_message(changes)
    data = ->(changes) do
      str = ''
      changes.each do |key, value|
        if @default_exclude_attrs.exclude?(key.to_s.to_sym)
          str += <<-DATA
          O atributo: #{key.to_s}
          Estava #{value.first}
          foi atualizado para #{value.last} \n
          DATA
        end
      end
      str
    end
    "Olá, esté é um informativo de que houve mudanças em seus dados cadastrais no MunicipeApp \n
      Os dados alterados estão descritos a baixo : \n
    #{data[changes]} \n
      qualquer dúvida estamos a disposição, tenha um ótimo dia!
    "
  end

  def format_create_message(changes)
    data = ->(changes) do
      str = ''
      changes.each do |key, value|
        if @default_exclude_attrs.exclude?(key.to_s.to_sym)
          str += <<-DATA
            #{key.to_s} : #{value} \n
          DATA
        end
      end
      str
    end
    " O seu cadastro foi concluído com sucesso, abaixo estão os dados cadastrados : \n
      Os dados cadastrados estão descritos a baixo : \n
    #{data[changes]} \n
     tenha um ótimo dia!
    "
  end

end