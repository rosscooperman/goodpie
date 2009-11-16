class RemoveNameAndStatusFromBuilds < ActiveRecord::Migration
  def self.up
    remove_column :builds, :name
    remove_column :builds, :status
  end

  def self.down
    add_column :builds, :name, :string
    add_column :builds, :status, :boolean
  end
end
