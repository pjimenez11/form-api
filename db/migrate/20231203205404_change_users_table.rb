class ChangeUsersTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :username

    # Add new columns
    add_column :users, :email, :string, default: "", null: false
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime
    add_column :users, :jti, :string, null: false

    add_index :users, :email, unique: true
    add_index :users, :jti, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
