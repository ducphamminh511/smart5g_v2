class CreateVcards < ActiveRecord::Migration[5.1]
  def change
    create_table :vcards do |t|
      t.string :name 
      t.string :organization
      t.string :mail
      t.string :phone
      t.text :address
      t.string :website
    end
  end
end
