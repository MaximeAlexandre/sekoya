# == Schema Information
#
# Table name: schedules
#
#  id          :bigint           not null, primary key
#  month       :integer
#  occurrences :string           default([]), is an Array
#  sch_type    :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_schedules_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Schedule < ApplicationRecord
  belongs_to :user
  serialize :occurences, Array

  validates :sch_type, inclusion: { in: %w(usual except) }
end
