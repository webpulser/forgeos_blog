class CreatePaper < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.belongs_to :person, :picture
      t.string :state
      t.timestamp :published_at

      t.timestamps
    end
    Paper.create_translation_table!(:name=>:string,:content=>:text,:url=>:string,:description=>:text)
  end

  def self.down
    Paper.drop_translation_table!
    drop_table :papers
  end
end
