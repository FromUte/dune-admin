module Dune::Admin
  class Reports::ContributionReportsController < Reports::BaseController
    def index
      project = Project.find(params[:project_id])
      render csv: ContributionReport.per_project(project)
    end
  end
end
