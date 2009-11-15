class Build < ActiveRecord::Base
  belongs_to :project

  def go
    exit_code = do_build
    if exit_code == 0
      project.update_attributes(:status => 'success')
    else
      project.update_attributes(:status => 'failed')
    end
    exit_code == 0
  end

  private

  def do_build
    repo_dir = File.join(BUILD_DIRECTORY, self.project.repo_name)
    IO.popen("cd #{repo_dir} && #{self.project.steps.first.command}") do |io|
      until io.eof?
        io.readline
      end
    end
    $?
  end
end
