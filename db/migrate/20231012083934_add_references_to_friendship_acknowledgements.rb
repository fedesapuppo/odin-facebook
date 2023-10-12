class AddReferencesToFriendshipAcknowledgements < ActiveRecord::Migration[7.0]
  def change
    add_reference :friendship_acknowledgements, :friend_request, null: false, foreign_key: true
    add_reference :friendship_acknowledgements, :friendship, null: false, foreign_key: true
  end
end
