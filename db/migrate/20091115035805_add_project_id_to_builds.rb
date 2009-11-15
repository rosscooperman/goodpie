class AddProjectIdToBuilds < ActiveRecord::Migration
  def self.up
    add_column :builds, :project_id, :integer
  end

  def self.down
    remove_column :builds, :project_id
  end
end
