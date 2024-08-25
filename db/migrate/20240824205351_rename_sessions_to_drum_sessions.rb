class RenameSessionsToDrumSessions < ActiveRecord::Migration[7.1]
  def change
    rename_table :sessions, :drum_sessions
  end
end