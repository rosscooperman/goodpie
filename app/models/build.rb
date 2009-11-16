class Build < ActiveRecord::Base
  belongs_to :project

  def go!
    exit_code = do_build
    if exit_code == 0
      project.update_attributes(:status => 'success')
    else
      project.update_attributes(:status => 'failed')
    end
    exit_code == 0
  end

  private

  def write_script
    repo_dir = File.join(BUILD_DIRECTORY, self.project.repo_name)
    filename = File.join(RAILS_ROOT, 'tmp', 'build.sh')
    File.open(filename, "w+") do |file|
      file << "#!/bin/sh\ncd #{repo_dir}\n#{self.project.steps.first.command}"
    end
    File.chmod(0755, filename)
    filename
  end

  def real_do_build
    output = ''
    IO.popen("sh #{write_script} 2>&1") do |io|
      until io.eof?
        output << io.readline
      end
      update_attribute(:output, output)
    end
    $?
  end

  def do_build
    real_do_build
  end
end
