class AddProductIdToPapers < ActiveRecord::Migration
  def self.up
    change_table :papers do |t|
      t.belongs_to :picture
    end
  end

  def self.down
    remove_column :papers, :picture_id
  end
end
