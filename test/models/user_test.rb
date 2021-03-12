# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  activity_start_date    :date
#  address                :string
#  address2               :string
#  car                    :boolean
#  description            :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  family_first_name      :string
#  family_last_name       :string
#  first_name             :string
#  handicap               :string
#  last_name              :string
#  latitude               :float
#  link                   :string
#  longitude              :float
#  mobile_number          :string
#  pathology              :string
#  photo                  :string
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
