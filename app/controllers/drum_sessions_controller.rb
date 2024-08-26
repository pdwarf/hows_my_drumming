class DrumSessionsController < ApplicationController
  before_action :authenticate_user!, except: [:feedback]
  before_action :set_drum_session, only: [:show, :update]

  def index
    @drum_sessions = current_user.drum_sessions.order(created_at: :desc)
  end

  def show
    @qr_code_url = user_feedback_url(current_user)
    @reactions = @drum_session.reactions
  end

  def new
    @drum_session = current_user.start_new_session
    redirect_to @drum_session, notice: 'New session started successfully.'
  end

  def update
    if @drum_session.update(active: false)
      redirect_to drum_sessions_path, notice: 'Session ended.'
    else
      redirect_to @drum_session, alert: 'Failed to end session.'
    end
  end

  def feedback
    @user = User.find(params[:user_id])
    @drum_session = @user.active_session
    if @drum_session
      @comments = @drum_session.comments
      @reactions = @drum_session.reactions
      render :feedback
    else
      render :no_active_session
    end
  end

  private

  def set_drum_session
    @drum_session = current_user.drum_sessions.find(params[:id])
  end
end