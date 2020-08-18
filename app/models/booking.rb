class Booking < ApplicationRecord
  belongs_to :helper, class_name: "User"
  belongs_to :senior, class_name: "User"
  has_many :reviews
  has_many :favoris
end
