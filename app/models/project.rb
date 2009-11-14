class Project < ActiveRecord::Base
  # associations
  has_many :steps

  # validations
  validates_presence_of :name, :repo, :branch
  validates_uniqueness_of :name

  # nested model "stuff"
  accepts_nested_attributes_for :steps, :allow_destroy => true

  # filters
  before_create :new_project_status

  # converts column names to human versions (where the build in humanization won't suffice)
  def self.human_attribute_name(key, options = {})
    return "Repository" if key == "repo"
    super(key, options)
  end

  private

  # method to set the project's status to the correct value for a new project
  def new_project_status
    self.status = 'new'
  end
end
