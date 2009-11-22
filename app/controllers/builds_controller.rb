class BuildsController < ApplicationController
  protect_from_forgery :except => :create

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

  def create
    project = Project.find(params[:project_id])
    if params.has_key?(:payload)
      json  = ActiveSupport::JSON.decode(params[:payload])
      build = project.builds.create(:commit => json["after"])
      if build.valid?
        build.go!
      end
    end

    render :nothing => true
  end

  def show
    @build = Build.find(params[:id])
  end
end
