require 'spec_helper'

describe Dune::Admin::ContactsController do
  routes { Dune::Admin::Engine.routes }
  let(:current_user){ create(:user, admin: true) }
  let(:contact) { create(:contact) }

  before do
    controller.stub(:current_user).and_return(current_user)
  end

  describe "GET 'index'" do
    before { get :index }
    it { expect(response).to be_success }
    it { expect(assigns(:contacts)).to eq [contact] }
  end

  describe "GET 'show'" do
    before { get :show, id: contact }
    it { expect(response).to be_success }
    it { expect(assigns(:contact)).to eq contact }
  end
end
