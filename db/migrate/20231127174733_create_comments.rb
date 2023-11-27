class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|

      t.text :body, null: false

      t.references :user, null: false, foreign_key: true 
      t.references :post, null: false, foreign_key: true 

      t.index [:user_id, :post_id], unique: true, name: "user_post_comment_index"

      t.timestamps
    end
  end
end
