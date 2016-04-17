class User < ActiveRecord::Base
  has_many :gifs
  has_secure_password
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { minimum: 1, maximum: 20 }, on: :create
end
