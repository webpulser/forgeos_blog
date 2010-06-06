class AddPublishedAtToPaper < ActiveRecord::Migration
  def self.up
    add_column :papers, :published_at, :timestamp
  end

  def self.down
    remove_column :papers, :published_at
  end
end
