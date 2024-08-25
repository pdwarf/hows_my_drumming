class Reaction < ApplicationRecord
  belongs_to :drum_session

  after_create_commit -> { broadcast_append_to [drum_session, :reactions] }

  enum emoji: {
    thumbs_up: 0,
    confetti: 1,
    horns: 2,
    dancer: 3,
    thinking_face: 4,
    thumbs_down: 5
  }

  validates :emoji, presence: true
end