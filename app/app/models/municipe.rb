class Municipe < ApplicationRecord

  has_one :endereco, dependent: :destroy
  has_one_attached :foto
  accepts_nested_attributes_for :endereco, reject_if: :all_blank

  validates_presence_of :nome, :cpf, :cns, :email, :dta_nasc, :telefone, :status ,:foto

  validates_length_of :nome, minimum: 1, maximum: 80
  validates_length_of :cpf, minimum: 11, maximum: 11
  validates_length_of :cns, minimum: 15, maximum: 15
  validates_length_of :email, minimum: 1, maximum: 256
  validates_length_of :telefone, minimum: 13, maximum: 13
  validate :validate_cpf, :validate_email, :validate_cns, :validate_nacimento

  enum status: { inactive: 0, active: 1 }
  scope :like, ->(term) {
    query = -> do
      qmunicipe = Municipe.columns.map(&:name).map { |attr| " CAST(#{Municipe.table_name}.#{attr} as varchar)  LIKE :term " }
      qendereco = Endereco.columns.map(&:name).map { |attr| "  CAST(#{Endereco.table_name}.#{attr} as varchar) LIKE :term " }
      "#{qmunicipe.join(" or ")} or #{ qendereco.join(" or ")}"
    end
    where(query.===, term: "%#{term}%")
  }

  def validate_cpf
    errors.add(:base, :invalid_cpf) unless Utility.cpf_is_valid?(cpf)
  end

  def validate_email
    errors.add(:base, :invalid_email) unless Utility.email_is_valid?(email)
  end

  def validate_cns
    errors.add(:base, :invalid_cns) unless Utility.cns_is_valid?(cns)
  end

  def validate_nacimento
    errors.add(:base, :invalid_birthday) unless Utility.nascimento_is_valid?(dta_nasc)
  end
end
