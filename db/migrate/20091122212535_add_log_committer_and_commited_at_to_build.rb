class AddLogCommitterAndCommitedAtToBuild < ActiveRecord::Migration
  def self.up
    add_column :builds, :log, :string
    add_column :builds, :committer, :string
    add_column :builds, :commited_at, :datetime
  end

  def self.down
    remove_column :builds, :commited_at
    remove_column :builds, :committer
    remove_column :builds, :log
  end
end
