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
#  task         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  helper_id    :bigint           not null
#  senior_id    :bigint           not null
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
require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
