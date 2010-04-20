class TasksController < ApplicationController

	layout 'general'

	before_filter :login_required

  # GET /tasks
  # GET /tasks.xml
  def index

      case params[:filter]
      when "scheduled"
          @tasks = Task.scheduled.recently_scheduled.per_project
      when "ongoing"
          @tasks = Task.ongoing.per_project
      when "done"
          @tasks = Task.done.recently_done.per_project
      else
          @tasks = Task.per_project
      end

      if !params[:project].blank?
          @tasks = @tasks.belong_to_project(params[:project])
      end

      if !params[:owner].blank?
          @tasks = @tasks.owned_by(params[:owner])
      end

      if !params[:organization].blank?
          @tasks = @tasks.belong_to_organization(params[:organization])
      end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/report/done
  # GET /tasks/report/done.xml
  def report_done
    @tasks = Task.find(:all, :conditions => [ "status = '진행중' OR (status = '완료' AND finish_date >= ?)", 7.days.ago ], :order => "category_name, project_name, title, finish_date")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/report/todo
  # GET /tasks/report/todo.xml
  def report_todo
    @tasks = Task.find(:all, :conditions => [ "status = '진행중' OR (status = '예정' AND estimated_start_date <= ?)", 7.days.from_now ], :order => "owner,category_name, project_name, title, finish_date")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy

    if !current_user.manager?
        flash[:error] = "Can't destroy a task if you're not a manager"
        respond_to do |format|
            format.html { redirect_to :back }
            format.xml { head :bad_request }
        end

        return

    end

    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
        format.html { redirect_to(tasks_url) }
        format.xml  { head :ok }
    end

  end

end
