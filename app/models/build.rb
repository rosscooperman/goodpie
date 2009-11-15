class Build < ActiveRecord::Base
  belongs_to :project

  def go
    repo_dir = File.join(BUILD_DIRECTORY, self.project.repo_name)
    IO.popen("cd #{repo_dir} && #{self.project.steps.first.command}") do |io|
      until io.eof?
        io.readline
      end
    end
    $? == 0
  end
end
