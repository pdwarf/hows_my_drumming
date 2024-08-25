class DrumSession < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :comments

  scope :active, -> { where(active: true) }
end