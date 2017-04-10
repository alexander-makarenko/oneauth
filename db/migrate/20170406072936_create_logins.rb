class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.integer :site_id
      t.string :auth_token

      t.timestamps
    end
    add_index :logins, :auth_token, unique: true
  end
end
