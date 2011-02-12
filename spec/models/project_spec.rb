require 'spec_helper'

describe Project do
  describe "an successfully cloned project instance" do
    subject { Factory.build(:project) }

    before(:each) do
      subject.stub(:delete_repository).and_return(nil)
      subject.stub(:real_clone_repository).and_return(0)
      subject.save
    end

    it { should have_many :steps }
    it { should have_many :builds }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }

    it { should validate_presence_of :repo }
    it { should validate_presence_of :branch }

    before(:each) do
      subject.stub(:real_clone_repository).and_return(0)
    end

    it "should have a status of cloned" do
      subject.status.should eq "cloned"
    end

    it "should have a successful clone status" do
      subject.status_message.should match /success.*clone/
    end
  end

  describe "an unsuccessfully cloned project instance" do
    subject { Factory.build(:project) }

    before(:each) do
      subject.stub(:real_clone_repository).and_return(1)
    end

    it "should fail to save" do
      lambda { subject.save! }.should raise_error ActiveRecord::RecordNotSaved
    end
  end
end