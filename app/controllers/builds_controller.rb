class BuildsController < ApplicationController

  def new
    project = Project.find(params[:project_id])
    build = project.builds.create
    if !build.valid?
      flash[:notice] = 'unable to create build'
    elsif build.go
      flash[:notice] = 'build successful'
      build.touch
    else
      flash[:error] = 'build failed'
      build.touch
    end
    redirect_to projects_path
  end
end
