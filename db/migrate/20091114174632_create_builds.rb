class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end
