module Dune::Admin
  class ChannelsController < BaseController
    defaults finder: :find_by_permalink
    actions :all, except: [:show]

    def create
      create! { channels_path }
    end

    def update
      update! { channels_path }
    end

    def destroy
      destroy! { channels_path }
    end

    def self.channel_actions
      %w[push_to_draft push_to_online].each do |action|
        define_method action do
          resource.send(action)
          flash.notice = I18n.t("dune.admin.channels.messages.successful.#{action}")
          redirect_to channels_path(params[:local_params])
        end
      end
    end
    channel_actions

    protected
    def collection
      @channels = apply_scopes(end_of_association_chain).order(:name).page(params[:page])
    end

    def permitted_params
      user_attrs = [user_attributes: User.attribute_names.map(&:to_sym)]
      aditional_attrs = [start_content: params.try(:[], :channel).
                                               try(:[], :start_content).
                                               try(:keys),

                         success_content: params.try(:[], :channel).
                                               try(:[], :success_content).
                                               try(:keys),]
      params.permit({ channel:
                      Channel.attribute_names.map(&:to_sym) +
                      user_attrs +
                      aditional_attrs })
    end
  end
end
