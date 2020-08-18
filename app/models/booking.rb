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
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end
end
