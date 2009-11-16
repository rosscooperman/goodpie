require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    Project.any_instance.stubs(:delete_repository).returns(nil)
  end

  context "A project instance" do
    subject { @project }

    setup do
      Project.any_instance.stubs(:real_clone_repository).returns(0)
      Project.any_instance.stubs(:delete_repository).returns(nil)
      @project = Factory(:project)
    end

    should_have_many :steps
    should_have_many :builds

    should_validate_presence_of :name, :repo, :branch
    should_validate_uniqueness_of :name
  end

  context "An successfully cloned project instance" do
    subject { @project }

    setup do
      Project.any_instance.stubs(:real_clone_repository).returns(0)
      Project.any_instance.stubs(:delete_repository).returns(nil)
      @project = Factory(:project)
    end

    should "have a successful clone status" do
      assert_equal @project.status, "cloned"
      assert_match /success.*clone/, @project.status_message
    end
  end

  context "An unsuccessfully cloned project instance" do
    subject { @project }

    setup do
      Project.any_instance.stubs(:real_clone_repository).returns(1)
      Project.any_instance.stubs(:delete_repository).returns(nil)
    end

    should "fail to save" do
      assert_raise ActiveRecord::RecordNotSaved do
        Factory(:project)
      end
    end
  end
end
