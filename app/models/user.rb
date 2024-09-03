class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :drum_sessions

  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: /\A[a-z0-9_]+\z/, message: "only allows lowercase letters, numbers, and underscores" }

  before_validation :downcase_username

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

  def to_param
    username.downcase
  end

  private

  def downcase_username
    self.username = username.downcase if username.present?
  end
  
end
