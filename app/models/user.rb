class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :drum_sessions

  def active_session
    drum_sessions.find_by(active: true)
  end

  def start_new_session
    DrumSession.transaction do
      active_session&.update!(active: false)
      drum_sessions.create!(active: true)
    end
  end
end
