# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  activity_start_date    :date
#  address                :string
#  car                    :boolean
#  description            :text
#  diploma                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  handicap               :string
#  last_name              :string
#  mobile_number          :integer
#  pathology              :string
#  price                  :integer
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
  has_many :helpers, class_name: "booking", foreign_key: "helper_id"
  has_many :seniors, class_name: "booking", foreign_key: "senior_id"
  has_many :reviews, through: :bookings
  has_many :favoris, through: :bookings

  validates :first_name, presence: true, uniqueness: true
  validates :last_name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :mobile_number, presence: true
  validates :pathology, presence: true
  validates :handicap, presence: true
  validates :diploma, presence: true
  validates :helpers, presence: true
  validates :seniors, presence: true


end
