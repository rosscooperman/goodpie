class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :output
end
