class AddRakismetAttributesToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :author, :string
    add_column :comments, :author_url, :string
    add_column :comments, :author_email, :string
    add_column :comments, :user_ip, :string
    add_column :comments, :user_agent, :string
    add_column :comments, :referrer, :string
  end

  def self.down
    remove_column :comments, :referrer
    remove_column :comments, :user_agent
    remove_column :comments, :user_ip
    remove_column :comments, :author_email
    remove_column :comments, :author_url
    remove_column :comments, :author
  end
end
