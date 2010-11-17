class ProjectsController < ApplicationController

	layout 'general'

	before_filter :login_required

  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all
    @active_projects = Project.find(:all, :conditions => "end_date IS NULL")
    @inactive_projects = Project.find(:all, :conditions => "end_date IS NOT NULL")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def approve
      project_name = params[:project]

      @project = Project.new
      @project.name = project_name

      if !@project.save then
          respond_to do |format|
              flash[:error] = "Project can't be created."
              format.html { redirect_to(:action => "unapproved") }
              format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
          end
          return
      end

      tasks = Task.find(:all, :conditions => "project_id is null and project_name = '" + project_name + "'")
      tasks.each do |task|
          task.project_id = @project.id
          task.save
      end

    respond_to do |format|
        flash[:notice] = 'Project was successfully approved.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
    end

  end

  # GET /projects/unapproved
  def unapproved

      @unapproved_projects = Task.find(:all, :select => 'project_name, count(*) count', :conditions => 'project_id is null', :group => 'project_name', :order => 'count desc')

      @candidate_projects = {}
      @unapproved_projects.each do |project|
          candidate_project = Project.find_by_name(project.project_name)
          @candidate_projects[project.project_name] = candidate_project
      end

      respond_to do |format|
          format.html # unapproved.html.erb
          format.xml  { render :xml => @unapproved_projects }
      end

  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
