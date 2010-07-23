class CreatePaper < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.belongs_to :person
      t.string :state

      t.timestamps
    end
    Paper.create_translation_table!(:name=>:string,:content=>:text,:url=>:string)
  end

  def self.down
    Paper.drop_translation_table!
    drop_table :papers
  end
end
