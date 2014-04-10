require 'spec_helper'

describe JobsController do
  let(:user) { double :user, organization: org }
  let(:org) { double :organization, id: '1', jobs: jobs_collection }
  let(:job) { double :job, id: '9' }
  let(:jobs_collection) { double :jobs_collection, find: job }
  before { Organization.stub find: org }

  describe 'GET index' do
    it 'assigns all jobs as @jobs' do
      get :index, { organization_id: org.id }
      assigns(:jobs).should eq jobs_collection
    end
    it 'non-org-owners allowed' do
      controller.stub current_user: user, org_owner?: false
      get :index, { organization_id: org.id }
      response.status.should eq 200
    end
    it 'mutation-proofing' do
      Organization.should_receive(:find).with(org.id) { org }
      org.should_receive(:jobs)
      get :index, { organization_id: org.id }
    end
  end

  describe 'GET show' do
    it 'assigns the requested job as @job' do
      get :show, { organization_id: org.id, id: job.id }
      assigns(:job).should eq job
    end
    it 'non-org-owners allowed' do
      controller.stub current_user: user, org_owner?: false
      get :show, { organization_id: org.id, id: job.id }
      response.status.should eq 200
    end
    it 'mutation-proofing' do
      Organization.should_receive(:find).with(org.id) { org }
      org.should_receive(:jobs) { jobs_collection }
      jobs_collection.should_receive(:find)
      get :show, { organization_id: org.id, id: job.id }
    end
  end

  describe 'GET new' do
    it 'assigns a new job as @job' do
      org.stub(:)

      get :new, { organization_id: org.id }
      assigns(:job).should be_a_new(Job)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested job as @job' do
      job = Job.create! valid_attributes
      get :edit, {:id => job.to_param}, valid_session
      assigns(:job).should eq(job)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Job' do
        expect {
          post :create, {:job => valid_attributes}, valid_session
        }.to change(Job, :count).by(1)
      end

      it 'assigns a newly created job as @job' do
        post :create, {:job => valid_attributes}, valid_session
        assigns(:job).should be_a(Job)
        assigns(:job).should be_persisted
      end

      it 'redirects to the created job' do
        post :create, {:job => valid_attributes}, valid_session
        response.should redirect_to(Job.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved job as @job' do
        # Trigger the behavior that occurs when invalid params are submitted
        Job.any_instance.stub(:save).and_return(false)
        post :create, {:job => {'title' => 'invalid value'}}, valid_session
        assigns(:job).should be_a_new(Job)
      end

      it 're-renders the "new" template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Job.any_instance.stub(:save).and_return(false)
        post :create, {:job => {'title' => 'invalid value'}}, valid_session
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested job' do
        job = Job.create! valid_attributes
        # Assuming there are no other jobs in the database, this
        # specifies that the Job created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Job.any_instance.should_receive(:update_attributes).with({'title' => 'MyString'})
        put :update, {:id => job.to_param, :job => {'title' => 'MyString'}}, valid_session
      end

      it 'assigns the requested job as @job' do
        job = Job.create! valid_attributes
        put :update, {:id => job.to_param, :job => valid_attributes}, valid_session
        assigns(:job).should eq(job)
      end

      it 'redirects to the job' do
        job = Job.create! valid_attributes
        put :update, {:id => job.to_param, :job => valid_attributes}, valid_session
        response.should redirect_to(job)
      end
    end

    describe 'with invalid params' do
      it 'assigns the job as @job' do
        job = Job.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Job.any_instance.stub(:save).and_return(false)
        put :update, {:id => job.to_param, :job => {'title' => 'invalid value'}}, valid_session
        assigns(:job).should eq(job)
      end

      it 're-renders the "edit" template' do
        job = Job.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Job.any_instance.stub(:save).and_return(false)
        put :update, {:id => job.to_param, :job => {'title' => 'invalid value'}}, valid_session
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested job' do
      job = Job.create! valid_attributes
      expect {
        delete :destroy, {:id => job.to_param}, valid_session
      }.to change(Job, :count).by(-1)
    end

    it 'redirects to the jobs list' do
      job = Job.create! valid_attributes
      delete :destroy, {:id => job.to_param}, valid_session
      response.should redirect_to(jobs_url)
    end
  end
end
