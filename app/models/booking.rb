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

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, "must be after the start time") if end_time < start_time
  end
end
