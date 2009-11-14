require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_have_many :steps

  should_validate_presence_of :name, :repo, :branch
  should_validate_uniqueness_of :name

  should "have a new status upon creation" do
    p = Project.create(:name => 'foo', :repo => 'bar', :branch => 'baz')
    p.save!
    assert_equal p.status, "new"
  end
end
