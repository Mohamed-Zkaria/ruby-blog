class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true, name: 'unique_emails' }
      t.string :password, null: false
      t.string :image, null: false 


      t.timestamps
    end
  end
end
