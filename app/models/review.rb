class Review < ApplicationRecord
  belongs_to :booking

  validates :note, presence: true, numericality: { only_integer: true }
  validates :note, inclusion: { in: 0..5, message: "It is not a valid note" }
  validates :content, presence: true
end
