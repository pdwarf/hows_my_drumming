class PagesController < ApplicationController
  def home
    redirect_to drum_sessions_path if user_signed_in?
  end
end