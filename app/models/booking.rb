# == Schema Information
#
# Table name: bookings
#
#  id           :bigint           not null, primary key
#  booking_step :integer
#  comment      :text
#  date         :date
#  end_time     :time
#  start_time   :time
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  helper_id    :bigint           not null
#  senior_id    :bigint
#
# Indexes
#
#  index_bookings_on_helper_id  (helper_id)
#  index_bookings_on_senior_id  (senior_id)
#
# Foreign Keys
#
#  fk_rails_...  (helper_id => users.id)
#  fk_rails_...  (senior_id => users.id)
#
class Booking < ApplicationRecord
  belongs_to :helper, class_name: "User"
  belongs_to :senior, class_name: "User", optional: true
  has_many :reviews
  has_many :favoris
  has_many :tasks

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, presence: true
  validate :end_time_after_start_time

  def display_review_form(user)
    (self.date < Date.today) && (Booking.find_by(senior_id: user.id).nil?)
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, "must be after the start time") if end_time < start_time
  end


end
