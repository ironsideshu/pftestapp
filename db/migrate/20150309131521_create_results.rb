class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :_id
      t.string :_rev
      t.string :barcode
      t.string :member_id
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :member_type
      t.string :status_code
      t.string :status_code_descr
      t.string :is_active
      t.string :pay_status

      t.timestamps null: false
    end
  end
end
