class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :mail
      t.string :phone_number
      t.text :message

      t.timestamps
    end
  end
end
