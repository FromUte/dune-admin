module Dune::Admin
  class PressAssetsController < BaseController
    actions :all, except: [:show]

    def create
      create! { press_assets_path }
    end

    def update
      update! { press_assets_path }
    end

    def destroy
      destroy! { press_assets_path }
    end

    protected
    def collection
      @press_assets ||= apply_scopes(end_of_association_chain).page(params[:page])
    end

    def permitted_params
      params.permit({ press_asset: PressAsset.attribute_names.map(&:to_sym) })
    end
  end
end
