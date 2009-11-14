class AddBranchToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :branch, :string
  end

  def self.down
    remove_column :projects, :branch
  end
end
