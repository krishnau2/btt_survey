class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :email_verification_token
      t.boolean :verified, :default => false
      t.boolean :admin, :default => false

      t.timestamps
    end
  end
end
