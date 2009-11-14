class AddRepositoryToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :repo, :string
  end

  def self.down
    remove_column :projects, :repo
  end
end
