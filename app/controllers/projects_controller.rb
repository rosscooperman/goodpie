class ProjectsController < ApplicationController

  def index
    @projects = Project.find(:all)
  end

  def new
    @project = Project.new
    @project.steps.build
  end

  def create
    @project = Project.create(params[:project])
    if @project.save
      flash[:notice] = "Project created successfully"
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    if @project.save
      flash[:notice] = "Project updated successfully"
      redirect_to projects_path
    else
      render :new
    end
  end

  def destroy
    if Project.find(params[:id]).destroy
      flash[:notice] = "Project removed successfully"
    else
      flase[:error] = "Unable to remove project"
    end
    redirect_to projects_path
  end
end
