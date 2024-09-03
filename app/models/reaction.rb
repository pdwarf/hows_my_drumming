class Reaction < ApplicationRecord
  belongs_to :drum_session

  after_create_commit -> { broadcast_replace_to [drum_session, :reactions], target: "reaction-stats", partial: "reactions/stats", locals: { reactions: drum_session.reactions } }

  enum emoji: {
    thumbs_up: 0,
    confetti: 1,
    horns: 2,
    dancer: 3,
    thinking_face: 4,
    thumbs_down: 5,
    shushing_face: 6,
    person_gesturing_no: 7
  }

  validates :emoji, presence: true
end