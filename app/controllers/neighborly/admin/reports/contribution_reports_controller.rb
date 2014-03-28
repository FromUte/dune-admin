module Neighborly::Admin
  class Reports::ContributionReportsController < Reports::ReportsController
    def end_of_association_chain
      super.where(project_id: params[:project_id])
    end
  end
end
