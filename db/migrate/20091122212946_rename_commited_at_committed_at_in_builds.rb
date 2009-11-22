class RenameCommitedAtCommittedAtInBuilds < ActiveRecord::Migration
  def self.up
    rename_column :builds, :commited_at, :committed_at
  end

  def self.down
    rename_column :builds, :committed_at, :commited_at
  end
end
