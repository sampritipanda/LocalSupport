class JobsController < ApplicationController
  before_filter :authorize, :except => [:index, :show]

  # GET organizations/1/jobs
  # GET organizations/1/jobs.json
  def index
    @organization = Organization.find(params[:organization_id])
    @jobs = @organization.jobs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @jobs }
    end
  end

  # GET organizations/1/jobs/1
  # GET organizations/1/jobs/1.json
  def show
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @job }
    end
  end

  # GET organizations/1/jobs/new
  # GET organizations/1/jobs/new.json
  def new
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @job }
    end
  end

  # GET organizations/1/jobs/1/edit
  def edit
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])
  end

  # POST organizations/1/jobs
  # POST organizations/1/jobs.json
  def create
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.build(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to([@job.organization, @job], :notice => 'Job was successfully created.') }
        format.json { render :json => @job, :status => :created, :location => [@job.organization, @job] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT organizations/1/jobs/1
  # PUT organizations/1/jobs/1.json
  def update
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to([@job.organization, @job], :notice => 'Job was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE organizations/1/jobs/1
  # DELETE organizations/1/jobs/1.json
  def destroy
    @organization = Organization.find(params[:organization_id])
    @job = @organization.jobs.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to organization_jobs_url(organization) }
      format.json { head :ok }
    end
  end

  private

  def authorize
    unless org_owner?
      flash[:error] = 'You must be signed in as an organization owner to perform this action!'
      redirect_to '/'
      false
    end
  end

  def org_owner?
    #
  end
end
