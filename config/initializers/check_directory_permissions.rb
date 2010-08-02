BUILD_DIRECTORY = File.join(Rails.root, 'build')

# do not do any of this in the test environment
unless Rails.env == "test"
  # check to make sure build directory exists (or make it)
  unless File.exists?(BUILD_DIRECTORY)
    begin
      Dir.mkdir(BUILD_DIRECTORY)
    rescue SystemCallError
      raise "directory '#{BUILD_DIRECTORY}' does not exist and could not be created"
    end
  end

  # check to make sure the current user can write to the build directory
  unless File.writable?(BUILD_DIRECTORY)
    raise "no write permissions on directory '#{BUILD_DIRECTORY}'"
  end

  @git_version =  `sh -ilc 'git --version'`
  unless @git_version.match /1\.[6-9]/
    raise "command 'git' not found in PATH or not version 1.6+ -- PATH => " +
          `sh -ilc 'echo $PATH'`
  end
end
