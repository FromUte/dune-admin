require 'spec_helper'

describe Dune::Admin::UsersController do
  routes { Dune::Admin::Engine.routes }
  subject{ response }
  let(:admin) { create(:user, admin: true) }
  let(:current_user){ admin }
  before do
    controller.stub(:current_user).and_return(current_user)
  end

  describe "GET index" do
    context "when I'm not logged in" do
      let(:current_user){ nil }
      before do
        get :index, :locale => :pt
      end
      it{ should redirect_to '/login' }
    end

    context "when I'm logged as admin" do
      before do
        get :index, :locale => :pt
      end
      its(:status){ should == 200 }
    end
  end

end

