class AddDescriptionToPapers < ActiveRecord::Migration
  def self.up
    add_column :paper_translations, :description, :text
  end

  def self.down
    remove_column :paper_translations, :description
  end
end
