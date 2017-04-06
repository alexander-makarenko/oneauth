class AddAuthDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_digest, :string
    add_index :users, :auth_digest, unique: true
  end
end
