class AddClomunToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :priority, :integer, null:false, default: 0
  end
end
