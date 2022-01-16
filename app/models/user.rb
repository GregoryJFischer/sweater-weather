class User < ApplicationRecord
  has_many :keys

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, require: true

  has_secure_password

  after_save :set_key

  def set_key
    self.keys.create if self.keys.empty?
  end
end