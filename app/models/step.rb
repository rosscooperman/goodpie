class Step < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :command
end
