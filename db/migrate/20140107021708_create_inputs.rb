class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :is_admin
      t.string :is_user
      t.string :is_client
      t.string :active

      t.timestamps
    end
  end
end
