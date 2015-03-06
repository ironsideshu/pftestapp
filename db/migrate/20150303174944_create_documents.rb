class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :member_id
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :member_type
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
