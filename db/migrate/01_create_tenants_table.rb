class CreateTenantsTable < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :username
      t.text :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
