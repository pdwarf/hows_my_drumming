class CommentsController < ApplicationController
  def create
    @drum_session = DrumSession.find(params[:drum_session_id])
    @comment = @drum_session.comments.new(comment_params)
    
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_feedback_path(@drum_session.user), notice: 'Comment was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_comment_form', partial: 'comments/form', locals: { drum_session: @drum_session }) }
        format.html { redirect_to user_feedback_path(@drum_session.user), alert: 'Failed to create comment.' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end