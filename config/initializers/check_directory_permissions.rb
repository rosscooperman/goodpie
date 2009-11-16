BUILD_DIRECTORY = File.join(RAILS_ROOT, 'build')

# do not do any of this in the test environment
unless RAILS_ENV == "test"
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

  unless `sh -ilc 'git --version'`.match /1\.6/
    raise "command 'git' not found in PATH or not version 1.6+"
  end
end
