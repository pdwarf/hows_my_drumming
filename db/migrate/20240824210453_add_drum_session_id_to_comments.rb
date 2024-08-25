class AddDrumSessionIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :drum_session, foreign_key: true
    
    # If you want to migrate existing data:
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE comments
          SET drum_session_id = (SELECT id FROM drum_sessions WHERE drum_sessions.id = comments.session_id)
        SQL
      end
    end
    
    remove_column :comments, :session_id, :integer
  end
end