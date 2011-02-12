require 'spec_helper'

describe Step do
#  subject { Factory(:step) }
  subject { Step.new }

  it { should belong_to :project }
  it { should validate_presence_of :command }
end