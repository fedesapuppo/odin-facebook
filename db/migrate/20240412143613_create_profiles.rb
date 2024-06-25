class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :surname
      t.date :date_of_birth
      t.text :bio
      t.string :phone_number
      t.string :profile_picture

      t.timestamps
    end
  end
end
