class ChangeFriendRequestStatusToEnum < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TABLE friend_requests
      ALTER COLUMN status TYPE integer
      USING CASE status
        WHEN 'pending' THEN 0
        WHEN 'accepted' THEN 1
        WHEN 'rejected' THEN 2
      END;
    SQL
  end
end
