class CreateFriendshipAcknowledgements < ActiveRecord::Migration[7.0]
  def change
    create_table :friendship_acknowledgements do |t|

      t.timestamps
    end
  end
end
