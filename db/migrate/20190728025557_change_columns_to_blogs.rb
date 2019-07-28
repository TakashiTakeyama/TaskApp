class ChangeColumnsToBlogs < ActiveRecord::Migration[5.2]
  def change
    change_column :blogs, :name, :string, null: false
    change_column :blogs, :details, :text, null: false
  end
end
