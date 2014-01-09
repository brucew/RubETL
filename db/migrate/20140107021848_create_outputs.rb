class CreateOutputs < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
