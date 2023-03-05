# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Required
      t.string :uid,                null: false, default: ''
      t.string :provider,           null: false, default: 'email'
      t.string :encrypted_password, null: false, default: ''

      ## Database authenticatable
      t.string :email,              null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Omniauth respond usually have these fields
      # Not used but if we start using Omniauth to allow
      # `Login with Google` or something we can add these fields
      # Or do as explained here:
      # https://github.com/lynndylanhurley/devise_token_auth/issues/304#issuecomment-233061552
      # t.string :name
      # t.string :nickname
      # t.string :image

      ## Tokens
      t.json :tokens

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, %i[uid provider], unique: true
  end
end
