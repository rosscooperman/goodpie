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

  def github_link(project, commit)
    "#{project.github_url}/commit/#{commit}"
  end

  def status_icon_for(status)
    case status
      when 'created'
        @img = '/images/icons/silk/page_white_add.png'
      when 'queued'
        @img = '/images/icons/silk/page_white_go.png'
      when 'building'
            @img = '/images/icons/silk/page_white_geard.png'
      when 'success'
        @img = '/images/icons/silk/accept.png'
      when 'failed'
        @img = '/images/icons/silk/exclamation.png'
    end

    image_tag(@img)
  end
end
