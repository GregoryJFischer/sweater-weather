class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  validates_presence_of :password, require: true

  has_secure_password

  def set_api_key
    self.api_key = SecureRandom.base64.tr('+-/=', 'Qrt')
  end
end