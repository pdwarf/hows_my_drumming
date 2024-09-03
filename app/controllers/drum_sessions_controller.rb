class DrumSessionsController < ApplicationController
  before_action :authenticate_user!, except: [:feedback]
  before_action :set_drum_session, only: [:show, :update]

  def index
    @drum_sessions = current_user.drum_sessions.order(created_at: :desc)
  end

  def show
    @reactions = @drum_session.reactions
    @comments = @drum_session.comments
  end

  def new
    @drum_session = current_user.start_new_session
    redirect_to @drum_session, notice: t('drum_sessions.notices.session_started')
  end

  def update
    if @drum_session.update(active: false)
      redirect_to drum_sessions_path, notice: t('drum_sessions.notices.session_ended')
    else
      redirect_to @drum_session, alert: t('drum_sessions.alerts.end_session_failed')
    end
  end

  def feedback
    @user = User.find_by!(username: params[:username].downcase)
    @drum_session = @user.active_session
    if @drum_session
      @comments = @drum_session.comments
      @reactions = @drum_session.reactions
      render :feedback
    else
      render :no_active_session
    end
  end

  def qr_code
    @qr_code_url = user_feedback_url(username: current_user.username)
  end

  private

  def set_drum_session
    @drum_session = current_user.drum_sessions.find(params[:id])
  end
end