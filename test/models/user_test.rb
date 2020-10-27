# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  activity_start_date    :date
#  address                :string
#  car                    :boolean
#  description            :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  handicap               :string
#  last_name              :string
#  latitude               :float
#  longitude              :float
#  mobile_number          :string
#  pathology              :string
#  photo                  :string           default("https://www.flaticon.com/svg/static/icons/svg/3237/3237472.svg")
#  price                  :float
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
