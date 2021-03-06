module Dune::Admin
  class FinancialsController < BaseController
    inherit_resources
    defaults  resource_class: Project, collection_name: 'projects', instance_name: 'project'

    has_scope :by_permalink, :name_contains, :user_name_contains, :financial, :with_state, :by_progress
    has_scope :between_expires_at, using: [ :start_at, :ends_at ], allow_blank: true

    respond_to :html, :csv

    actions :index

    def index
      respond_to do |format|
        format.html { collection }
        format.csv do
          render csv: (collection.map do |resource|
            ProjectFinancial.new(resource)
          end)
        end
      end
    end

    protected
    def projects
      apply_scopes(Project).includes(:user).order("CASE state WHEN 'successful' THEN 1 WHEN 'waiting_funds' THEN 2 ELSE 3 END, (projects.expires_at)::date DESc")
    end

    def collection
      @projects ||= projects.page(params[:page])
    end
  end
end
