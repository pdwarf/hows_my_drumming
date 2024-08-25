class AddDrumSessionIdToReactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :reactions, :drum_session, foreign_key: true
    
    # If you want to migrate existing data:
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE reactions
          SET drum_session_id = (SELECT id FROM drum_sessions WHERE drum_sessions.id = reactions.session_id)
        SQL
      end
    end
    
    remove_column :reactions, :session_id, :integer
  end
end