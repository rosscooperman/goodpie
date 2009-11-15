class Project < ActiveRecord::Base
  # associations
  has_many :steps
  has_many :builds

  # validations
  validates_presence_of :name, :repo, :branch
  validates_uniqueness_of :name

  # nested model "stuff"
  accepts_nested_attributes_for :steps, :allow_destroy => true

  # filters
  before_create :new_project_status, :clone_repository
  after_destroy :delete_repository

  # map of statuses to status messages
  STATUS_MESSAGES = {
    :new        => "project has never been built",
    :cloned     => "repository has been successfully cloned",
    :clonefail  => "failed to clone repository",
    :success    => "last build was successful",
    :failed     => "last build was a failure"
  }

  # converts column names to human versions (where the build in humanization won't suffice)
  def self.human_attribute_name(key, options = {})
    return "Repository" if key == "repo"
    super(key, options)
  end

  # provide a human-readable version of status
  def status_message
    STATUS_MESSAGES[self.status.to_sym] || "project status is unknown"
  end

  def repo_name
    self.name.gsub(/ /, '_').downcase
  end

  #
  # PRIVATE METHODS
  #
  private

  # method to set the project's status to the correct value for a new project
  def new_project_status
    self.status = 'new'
  end

  # method to just do the repository cloning (this can be stubbed out for testing)
  def real_clone_repository
    IO.popen("cd #{BUILD_DIRECTORY} && git clone #{self.repo} #{self.repo_name}") do |io|
      until io.eof?
        io.readline
      end
    end
    $?
  end

  # method to make sure the repository can be checked out before allowing project to be created
  def clone_repository
    if real_clone_repository == 0
      self.status = 'cloned'
    else
      self.status = 'clonefail'
      self.errors.add_to_base("unable to clone the specified repository")
      return false
    end
  end

  def delete_repository
    FileUtils.rm_rf(File.join(BUILD_DIRECTORY, self.repo_name))
  end
end
