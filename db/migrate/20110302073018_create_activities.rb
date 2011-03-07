class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :source_id, :null => false
      t.string :title
      t.string :link
      t.text :content
      t.string :creator
      t.datetime :publish_at

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
