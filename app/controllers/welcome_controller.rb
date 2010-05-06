class WelcomeController < ApplicationController
	layout 'general'

	def index

        if current_user then
            @tasks = Task.owned_by(current_user.id).per_project

            @scheduled_tasks = Task.scheduled.recently_scheduled.owned_by(current_user.id).per_project
            @ongoing_tasks = Task.ongoing.owned_by(current_user.id).per_project
            @done_tasks = Task.done.recently_done.owned_by(current_user.id).per_project
        end

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @tasks }
        end

	end
end
