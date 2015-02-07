class NoteTaking < ActiveRecord::Migration
  def self.up
    create_table :notes do |n|
      n.string :content, :null => false
    end
  end

  def self.down
    drop_table :notes
  end
end
