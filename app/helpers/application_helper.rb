module ApplicationHelper
  def nice_time(time)
    if time.nil?
      "unknown"
    elsif time > Chronic.parse("today")
      "today"
    elsif time > Chronic.parse("yesterday")
      "yesterday"
    else
      time.strftime "%x"
    end
  end

  def build_display(build)
    "#{build.commit[0,6]}(#{build.id})"
  end
end
