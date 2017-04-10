class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :domain
      t.string :secret_key
      t.string :user_update_callback
      t.string :auth_token_callback

      t.timestamps
    end
    add_index :sites, :domain, unique: true
    add_index :sites, :secret_key, unique: true
    add_index :sites, :auth_token_callback, unique: true
  end
end
