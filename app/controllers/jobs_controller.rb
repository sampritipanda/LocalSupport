class JobsController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    @jobs = @organization.jobs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
end
