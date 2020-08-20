# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  booking_id :bigint
#
# Indexes
#
#  index_tasks_on_booking_id  (booking_id)
#
# Foreign Keys
#
#  fk_rails_...  (booking_id => bookings.id)
#
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
