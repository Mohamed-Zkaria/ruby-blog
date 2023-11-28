class RemoveCompositeIndeFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_index :comments, name: "user_post_comment_index" 
  end
end
