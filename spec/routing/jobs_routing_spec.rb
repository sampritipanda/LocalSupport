require "spec_helper"

describe JobsController do
  describe "routing" do
    let(:org) { double 'Organization', id: 1 }

    # /organizations/:organization_id/jobs
    it "routes to #index" do
      get("/organizations/#{org.id}/jobs").should route_to(
                                                      {
                                                          action: 'index',
                                                          controller: 'jobs',
                                                          organization_id: '1'
                                                      }
                                                  )
    end

    it "routes to #new" do
      get("/organizations/#{org.id}/jobs/new").should route_to(
                                                      {
                                                          action: 'new',
                                                          controller: 'jobs',
                                                          organization_id: '1'
                                                      }
                                                               )
    end
    
    it "routes to #show" do
      get("/organizations/#{org.id}/jobs/9").should route_to(
                                                      {
                                                          action: 'show',
                                                          controller: 'jobs',
                                                          organization_id: '1',
                                                          id: '9'
                                                      }
                                                               )
    end

    it "routes to #edit" do
      get("/organizations/#{org.id}/jobs/9/edit").should route_to(
                                                      {
                                                          action: 'edit',
                                                          controller: 'jobs',
                                                          organization_id: '1',
                                                          id: '9'
                                                      }
                                                               )
    end

    it "routes to #create" do
      post("/organizations/#{org.id}/jobs").should route_to(
                                                      {
                                                          action: 'create',
                                                          controller: 'jobs',
                                                          organization_id: '1',
                                                      }
                                                               )
    end


    it "routes to #update" do
      put("/organizations/#{org.id}/jobs/9").should route_to(
                                                      {
                                                          action: 'update',
                                                          controller: 'jobs',
                                                          organization_id: '1',
                                                          id: '9'
                                                      }
                                                               )
    end
    

    it "routes to #destroy" do
      delete("/organizations/#{org.id}/jobs/9").should route_to(
                                                      {
                                                          action: 'destroy',
                                                          controller: 'jobs',
                                                          organization_id: '1',
                                                          id: '9'
                                                      }
                                                               )
    end
  end
end
