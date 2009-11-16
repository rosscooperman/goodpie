class AddOutputAndStatusToBuilds < ActiveRecord::Migration
  def self.up
    add_column :builds, :output, :string
    add_column :builds, :status, :string
  end

  def self.down
    remove_column :builds, :status
    remove_column :builds, :output
  end
end
