class AddCommentCountTo < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :comments_count, :integer, default: 0
    Article.reset_column_information

    Article.all.each do |a|
      Article.update_counters a.id, comments_count: a.comments.length
    end
  end

  def down
    remove_column :articles, :comments_count
  end
end
