class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.belongs_to :person
      t.string :state

      t.timestamps
    end
    Post.create_translation_table!(:name=>:string,:content=>:text,:url=>:string)
  end

  def self.down
    Post.drop_translation_table!
    drop_table :posts
  end
end
