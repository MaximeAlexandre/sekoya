class Booking < ApplicationRecord
  belongs_to :helper, class_name: "User"
  belongs_to :senior, class_name: "User"
  has_many :reviews
  has_many :favoris

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, presence: true
  validates :task, presence: true
end
