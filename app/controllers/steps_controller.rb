class StepsController < ApplicationController
  protect_from_forgery :except => :create

  def create
    project = Project.find(params[:project_id])
    project.steps.build.save!

    redirect_to edit_project_path project
  end
end
