class Build < ActiveRecord::Base
  belongs_to :project

  # filters
  before_create :set_defaults

  # map of statuses to status messages
  STATUS_MESSAGES = {
    :created    => "has been created",
    :queued     => "has been queued",
    :building   => "is in progress",
    :success    => "was successful",
    :failed     => "was a failure"
  }

  # provide a human-readable version of status
  def status_message
    return "build status is unknown" if self.status.blank?
    STATUS_MESSAGES[self.status.to_sym] || "build status is unknown"
  end

  def repo_dir
    File.join(BUILD_DIRECTORY, self.project.repo_name)
  end

  def go!
    self.send_later(:do_build)
    update_attributes(
      :status => "queued"
    )
  end

  def do_build
    output = ''
    update_attribute(:status, "building")
    project.update_attribute(:status, "building")

    # make sure the repository is where it should be
    temp = `sh -ilc 'cd #{repo_dir} && git checkout #{self.project.branch} && git pull'`
    unless commit.nil?
      temp = `sh -ilc 'cd #{repo_dir} && git reset --hard #{commit}'`
    end

    commit = Grit::Repo.new(repo_dir).commits.first
    update_attributes(
      :commit       => commit.id,
      :log          => commit.message,
      :committer    => commit.committer.name,
      :committed_at => commit.committed_date
    )

    IO.popen("sh #{write_script} 2>&1") do |io|
      until io.eof?
        output << io.readline
      end
      self.output = output
    end

    self.status = ($? == 0) ? "success" : "failed"
    project.update_attribute(:status, self.status)
    save!
  end

  private

  def set_defaults
    if self.status.nil?
      self.status = "created"
    end
    if self.log.nil?
      self.log = "<not populated yet>"
    end
    if self.committer.nil?
      self.committer = "<not populated yet>"
    end
  end

  def write_script
    filename = File.join(Rails.root, 'tmp', 'build.sh')
    File.open(filename, "w+") do |file|
      file << "#!/bin/sh\ncd #{repo_dir}\n#{self.project.steps.first.command}"
    end
    File.chmod(0755, filename)
    filename
  end
end
