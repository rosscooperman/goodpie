require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_have_many :steps
  should_have_many :builds

  should_validate_presence_of :name, :repo, :branch
  should_validate_uniqueness_of :name

  should "have a successful clone status upon sucessful 'git clone'" do
    Project.any_instance.stubs(:real_clone_repository).returns(0)
    p = Project.create(:name => 'foo', :repo => 'bar', :branch => 'baz')
    p.save
    assert_equal p.status, "cloned"
    assert_match /success.*clone/, p.status_message
  end

  should "set failed clone status upon failed 'git clone'" do
    Project.any_instance.stubs(:real_clone_repository).returns(1)
    p = Project.create(:name => 'foo', :repo => 'bar', :branch => 'baz')
    p.save
    assert_equal p.status, "clonefail"
    assert_match /fail.*clone/, p.status_message
  end

end
