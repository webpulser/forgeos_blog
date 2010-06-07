class RenameCommentsAuthorToAuthorName < ActiveRecord::Migration
  def self.up
    rename_column :comments, :author, :author_name
  end

  def self.down
    rename_column :comments, :author_name, :author
  end
end
