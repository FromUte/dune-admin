module Dune::Admin
  class Reports::BaseController < BaseController
    inherit_resources
    responders :csv
    respond_to :csv
    actions :index
  end
end
