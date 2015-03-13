class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.string :barcode
      t.string :program
      t.string :brand
      t.string :perk_name
      t.string :perk_descr
      t.string :open_time
      t.string :click_time
      t.string :redeemed_time
      t.string :redeemed_loc
      t.string :gross_amt
      t.string :discount_amt
      t.string :is_perk

      t.timestamps null: false
    end
  end
end
