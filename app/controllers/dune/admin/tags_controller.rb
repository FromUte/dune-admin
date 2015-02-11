module Dune::Admin
  class TagsController < BaseController
    actions :all, except: [:show]
    has_scope :popular, type: :boolean

    def create
      create! { tags_path }
    end

    def update
      update! do |format|
        if resource.errors.empty?
          format.html { redirect_to tags_path }
          format.json { respond_with_bip(resource) }
        else
          format.html { render action: 'edit' }
          format.json { respond_with_bip(resource) }
        end
      end
    end

    def destroy
      destroy! { tags_path }
    end

    protected
    def collection
      @tags ||= apply_scopes(end_of_association_chain).order('created_at desc').page(params[:page])
    end

    def permitted_params
      params.permit({ tag: Tag.attribute_names.map(&:to_sym) })
    end
  end
end
