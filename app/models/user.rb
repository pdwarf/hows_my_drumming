class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :drum_sessions

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }

  def active_session
    drum_sessions.find_by(active: true)
  end

  def admin?
    admin
  end

  def start_new_session
    DrumSession.transaction do
      active_session&.update!(active: false)
      drum_sessions.create!(active: true)
    end
  end
end
