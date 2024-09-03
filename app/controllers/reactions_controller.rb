class ReactionsController < ApplicationController
  before_action :set_drum_session

  def create
    @reaction = @drum_session.reactions.new(reaction_params)
    
    if @reaction.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @drum_session }
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def set_drum_session
    @drum_session = DrumSession.find(params[:drum_session_id])
  end

  def reaction_params
    params.require(:reaction).permit(:emoji)
  end
end