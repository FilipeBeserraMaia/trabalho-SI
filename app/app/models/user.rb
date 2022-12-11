class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_confirmed_at

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]


  def set_confirmed_at
    self.confirmed_at = Date.today
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(email: data['email'],
                         password: Devise.friendly_token[0, 20], confirmed_at: Date.today, kind: :municipe)
    user
  end
end
