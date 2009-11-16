class BuildsController < ApplicationController

  def new
    project = Project.find(params[:project_id])
    build = project.builds.create
    if !build.valid?
      flash[:notice] = 'unable to create build'
      redirect_to :back
    else
      build.go!
      redirect_to project_build_path(project, build)
    end
  end

  def show
    @build = Build.find(params[:id])
  end
end
