class CreateRequestsTable < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :content
      t.text :apt_num
      t.text :date
      t.integer :tenant_id

      t.timestamps null: false
    end
  end
end
