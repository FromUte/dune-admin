module Dune
  module Admin
    class Engine < ::Rails::Engine
      isolate_namespace Dune::Admin

      config.to_prepare do
        ::Project.send(:include, Dune::Admin::ProjectConcern)
        ::User.send(:include, Dune::Admin::UserConcern)
        ::Contribution.send(:include, Dune::Admin::ContributionConcern)
      end
    end
  end
end
