require 'test_helper'

class StepTest < ActiveSupport::TestCase
  should_belong_to :project

  should_validate_presence_of :command
end
