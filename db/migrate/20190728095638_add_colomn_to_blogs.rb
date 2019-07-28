class AddColomnToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :expired_at, :datetime, null:false, default: DateTime.now
  end
end
