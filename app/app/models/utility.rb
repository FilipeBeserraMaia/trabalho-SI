class Utility
  Utility::CNS_SIZE = 15
  Utility::TimeYears = ->(date) { (Time.now.to_fs(:number).to_i - date.to_time.to_fs(:number).to_i) / 10e9.to_i if date.present? }

  require "cpf_cnpj"

  # Translators
  def self.translate_form(key)
    I18n.t("activerecord.form.#{key.to_s}")
  end

  def self.translate_class_name(klass)
    I18n.t("activerecord.attributes.#{klass.to_s.underscore}.class_name")
  end

  def self.translate_attr(klass, attr)
    I18n.t("activerecord.attributes.#{klass.to_s.underscore}.#{attr.to_s}")
  end

  def self.translate_actions(klass, attr)
    I18n.t("activerecord.attributes.#{klass.to_s.underscore}.actions.#{attr.to_s}")
  end

  def self.translate_enum_name(class_name, enum_name, enum_value)
    return nil unless enum_value
    I18n.t("activerecord.attributes.#{class_name.to_s.underscore}.#{enum_name}.#{enum_value}")
  end

  #Validators
  def self.cpf_is_valid?(cpf_number)
    CPF.valid?(cpf_number.to_s)
  end

  def self.email_is_valid?(email)
    email.to_s.match(URI::MailTo::EMAIL_REGEXP).present?
  end

  def self.nascimento_is_valid?(date)
    return false unless date.present?
    age = self.time_in_years(date)
    age >= 0 and age <= 130
  end

  def self.cns_is_valid?(cns)

    cns = cns.to_s.gsub(/[^0-9]/, "")
    return false if cns.size != Utility::CNS_SIZE
    total = 0
    0..15.times { |i| total += cns[i].to_i * (Utility::CNS_SIZE - i) }
    total % 11 == 0
  end

  # Formatters
  def self.cpf_stripped(cpf_number)
    cpf = CPF.new(cpf_number.to_s)
    cpf.stripped
  end

  def self.cpf_formatted(cpf_number)
    cpf = CPF.new(cpf_number.to_s)
    cpf.formatted
  end

  def self.date_formatted(date)
    date.strftime("%d/%m/%Y")
  end

  def self.phone_br_formatted(phone)
    phone.gsub(/^(\d{2})(\d{2,2})(\d{4,5})(\d{4})$/, '+\1 (\2) \3-\4')
  end

  def self.phone_br_stripped(phone)
    phone.gsub(/[^0-9]/, '')
  end

  def self.cns_formatted(cns)
    cns.gsub(/^(\d{3})(\d{4})(\d{4})(\d{4})$/, '\1 \2 \3 \4')
  end

  def self.cep_formatted(cep)
    cep.gsub(/^(\d{5})(\d{3})$/, '\1-\2')
  end

  #others

  def self.time_in_years(date)
    Utility::TimeYears.=== date
  end

end
