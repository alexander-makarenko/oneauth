class AddUniqueIndexToLogins < ActiveRecord::Migration[5.0]
  def change
    add_index :logins, [:user_id, :site_id], unique: true
  end
end
