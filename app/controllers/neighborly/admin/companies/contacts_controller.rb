module Neighborly::Admin
  class Companies::ContactsController < BaseController
    defaults class_name: 'CompanyContact'
    actions :index, :show

    def collection
      @contacts ||= apply_scopes(end_of_association_chain).order('created_at desc').page(params[:page])
    end
  end
end
