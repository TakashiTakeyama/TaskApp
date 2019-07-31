class AddColumnToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :state, :string, null:false, default: "完了"
  end
end
