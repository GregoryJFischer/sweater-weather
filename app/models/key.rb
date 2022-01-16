class Key < ApplicationRecord
  belongs_to :user

  validates :value, uniqueness: true

  before_save :set_value

  def set_value
    self.value = SecureRandom.base64.tr('+-/=', 'Qrt') if self.value.nil?
  end
end