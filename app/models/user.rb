class User < ApplicationRecord
  has_many :trips
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
