class Build < ActiveRecord::Base
  belongs_to :project

  # map of statuses to status messages
  STATUS_MESSAGES = {
    :queued     => "build has been queued",
    :building   => "build is in progress",
    :success    => "build was successful",
    :failed     => "build was a failure"
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
      :status => "queued",
      :commit => '??????'
    )
  end

  def do_build
    output = ''
    update_attribute(:status, "building")

    # make sure the repository is where it should be
    temp = `sh -ilc 'cd #{repo_dir} && git checkout #{self.project.branch} && git pull'`

    IO.popen("sh #{write_script} 2>&1") do |io|
      until io.eof?
        output << io.readline
      end
      update_attributes(
        :output => output,
        :commit => `sh -ilc 'cd #{repo_dir} && git log -1 --pretty=format:"%h"'`
      )
    end

    if $? == 0
      update_attribute(:status, "success")
    else
      update_attribute(:status, "failed")
    end
  end

  private

  def write_script
    filename = File.join(RAILS_ROOT, 'tmp', 'build.sh')
    File.open(filename, "w+") do |file|
      file << "#!/bin/sh\ncd #{repo_dir}\n#{self.project.steps.first.command}"
    end
    File.chmod(0755, filename)
    filename
  end
end
