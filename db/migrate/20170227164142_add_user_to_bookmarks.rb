class AddUserToBookmarks < ActiveRecord::Migration
  def change
    def change
      add_column :bookmarks, :user_id, :integer
      add_index :bookmarks, :user_id
    end
  end
end
