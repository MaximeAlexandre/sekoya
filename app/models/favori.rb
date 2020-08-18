# == Schema Information
#
# Table name: favoris
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  booking_id :bigint           not null
#
# Indexes
#
#  index_favoris_on_booking_id  (booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (booking_id => bookings.id)
#
class Favori < ApplicationRecord
  belongs_to :booking
end
