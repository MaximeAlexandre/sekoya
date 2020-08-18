# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  content    :text
#  note       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  booking_id :bigint           not null
#
# Indexes
#
#  index_reviews_on_booking_id  (booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (booking_id => bookings.id)
#
class Review < ApplicationRecord
  belongs_to :booking
end
