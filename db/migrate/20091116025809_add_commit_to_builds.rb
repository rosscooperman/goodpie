class AddCommitToBuilds < ActiveRecord::Migration
  def self.up
    add_column :builds, :commit, :string
  end

  def self.down
    remove_column :builds, :commit
  end
end
