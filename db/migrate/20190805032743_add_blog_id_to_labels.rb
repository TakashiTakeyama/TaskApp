class AddBlogIdToLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :labels, :blog_id, :integer
  end
end
