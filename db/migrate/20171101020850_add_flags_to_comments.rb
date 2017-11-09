class AddFlagsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :flags, :integer, default: 0
  end
end
