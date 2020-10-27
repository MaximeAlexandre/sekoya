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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :bookings
  has_many :diplomas
  has_many :schedules

  has_many :reviews, through: :bookings
  has_many :favoris, through: :bookings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :role, presence: true
  validates :description, presence: true, if: proc { |user| user.role == "helper" }
  validates :price, presence: true, if: proc { |user| user.role == "helper" }
  validates :mobile_number, presence: true, uniqueness: true
end
