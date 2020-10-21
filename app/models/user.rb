class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: 6 }
  
end