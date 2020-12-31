require 'bcrypt'

class User < ActiveRecord::Base
  # users.password_hash in the database is a :string
  include BCrypt
  has_secure_password
  validates :username,presence: true
  validates :username,uniquensess:true
  has_many :grievances
end
