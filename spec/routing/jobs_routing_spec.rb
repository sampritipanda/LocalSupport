require "spec_helper"

describe JobsController do
  describe "routing" do
    it "routes to #index" do
      get("/organizations/1/jobs").should route_to(
                                              {
                                                  action: 'index',
                                                  controller: 'jobs',
                                                  organization_id: '1'
                                              }
                                          )
    end

    it "routes to #new" do
      get("/organizations/1/jobs/new").should route_to(
                                                  {
                                                      action: 'new',
                                                      controller: 'jobs',
                                                      organization_id: '1'
                                                  }
                                              )
    end

    it "routes to #show" do
      get("/organizations/1/jobs/9").should route_to(
                                                {
                                                    action: 'show',
                                                    controller: 'jobs',
                                                    organization_id: '1',
                                                    id: '9'
                                                }
                                            )
    end

    it "routes to #edit" do
      get("/organizations/1/jobs/9/edit").should route_to(
                                                     {
                                                         action: 'edit',
                                                         controller: 'jobs',
                                                         organization_id: '1',
                                                         id: '9'
                                                     }
                                                 )
    end

    it "routes to #create" do
      post("/organizations/1/jobs").should route_to(
                                               {
                                                   action: 'create',
                                                   controller: 'jobs',
                                                   organization_id: '1',
                                               }
                                           )
    end


    it "routes to #update" do
      put("/organizations/1/jobs/9").should route_to(
                                                {
                                                    action: 'update',
                                                    controller: 'jobs',
                                                    organization_id: '1',
                                                    id: '9'
                                                }
                                            )
    end


    it "routes to #destroy" do
      delete("/organizations/1/jobs/9").should route_to(
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
