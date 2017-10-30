class AddUpvotedAndDownvotedCommentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :upvoted_comments, :text
    add_column :users, :downvoted_comments, :text
  end
end
