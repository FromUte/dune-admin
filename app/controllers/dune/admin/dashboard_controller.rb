module Dune::Admin
  class DashboardController < BaseController
    inherit_resources
    defaults  resource_class: Statistics
    actions :index
  end
end

