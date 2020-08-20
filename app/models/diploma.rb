# == Schema Information
#
# Table name: diplomas
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_diplomas_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Diploma < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id
end
