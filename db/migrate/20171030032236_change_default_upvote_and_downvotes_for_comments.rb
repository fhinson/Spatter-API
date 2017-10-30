class ChangeDefaultUpvoteAndDownvotesForComments < ActiveRecord::Migration
  def change
    change_column_default :comments, :upvotes, 0
    change_column_default :comments, :downvotes, 0
  end
end
