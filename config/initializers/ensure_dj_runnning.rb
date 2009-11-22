# do not do any of this in the test environment
unless RAILS_ENV == "test"
  # determine the process status of the current delayed job worker
  DJ_PIDFILE = "#{RAILS_ROOT}/tmp/pids/dj.pid"
  system("[ -e #{DJ_PIDFILE} ] && ps -p `cat #{DJ_PIDFILE}` | grep -q Delayed");

  # if the process is not currently running, start a new one (this should pretty much happen
  # every time the server gets started but just in case, only one delayed job worker at a time)
  if $? != 0
    pid = fork
    if pid.nil?
      $0 = 'Delayed job: worker'
      Delayed::Job.const_set("MAX_ATTEMPTS", 1)
      Delayed::Worker.new.start
      exit(0)
    else
      File.open(DJ_PIDFILE, "w+") do |file|
        file.write pid
      end
      Process.detach(pid)
    end
  end
end