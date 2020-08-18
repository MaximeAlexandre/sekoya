class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :helpers, class_name: "booking", foreign_key: "helper_id"
  has_many :seniors, class_name: "booking", foreign_key: "senior_id"
  has_many :reviews, through: :bookings
  has_many :favoris, through: :bookings
end
