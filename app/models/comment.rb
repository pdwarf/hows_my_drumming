class Comment < ApplicationRecord
  belongs_to :drum_session

  validates :content, presence: true

  after_create_commit -> { broadcast_append_to [drum_session, :comments] }
end