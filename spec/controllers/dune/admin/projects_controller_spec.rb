require 'spec_helper'

describe Dune::Admin::ProjectsController do
  routes { Dune::Admin::Engine.routes }
  subject{ response }
  let(:admin) { create(:user, admin: true) }
  let(:current_user){ admin }

  before do
    controller.stub(:current_user).and_return(current_user)
    request.env['HTTP_REFERER'] = projects_path
  end

  describe 'PUT launch' do
    let(:project) { create(:project, state: 'draft') }
    subject { project.online? }

    before do
      put :launch, id: project, locale: :pt
    end

    it do
      project.reload
      should be_true
    end
  end

  describe 'PUT reject' do
    let(:project) { create(:project, state: 'draft') }
    subject { project.rejected? }

    before do
      put :reject, id: project, locale: :pt
      project.reload
    end

    it { should be_true }
  end

  describe 'PUT push_to_draft' do
    let(:project) { create(:project, state: 'online') }
    subject { project.draft? }

    before do
      controller.stub(:current_user).and_return(admin)
      put :push_to_draft, id: project, locale: :pt
    end

    it do
      project.reload
      should be_true
    end
  end

  describe "GET index" do
    context "when I'm not logged in" do
      let(:current_user){ nil }
      before do
        get :index, locale: :pt
      end
      it{ should redirect_to '/login' }
    end

    context "when I'm logged as admin" do
      before do
        get :index, locale: :pt
      end
      its(:status){ should == 200 }
    end
  end

  describe '.collection' do
    let(:project) { create(:project, name: 'Project for search') }
    context "when there is a match" do
      before do
        get :index, locale: :pt, pg_search: 'Project for search'
      end
      it{ assigns(:projects).should eq([project]) }
    end

    context "when there is no match" do
      before do
        get :index, locale: :pt, pg_search: 'Foo Bar'
      end
      it{ assigns(:projects).should eq([]) }
    end
  end

  describe "DELETE destroy" do
    let(:project) { create(:project, state: 'draft') }

    context "when I'm not logged in" do
      let(:current_user){ nil }
      before do
        delete :destroy, id: project, locale: :pt
      end
      it{ should redirect_to '/login'  }
    end

    context "when I'm logged as admin" do
      before do
        delete :destroy, id: project, locale: :pt
      end

      its(:status){ should redirect_to projects_path }

      it 'should change state to deleted' do
        expect(project.reload.deleted?).to be_true
      end
    end
  end

  describe "POST populate" do
    let(:project) { create(:project, state: 'online') }

    context "when I'm not logged in" do
      let(:current_user){ nil }
      before do
        post :populate, id: project
      end
      it{ should redirect_to '/login' }
    end

    context "when I'm logged as admin" do
      let(:reward) { create(:reward, project: project) }

      shared_examples_for 'create the contribution' do
        subject { project.contributions.first }

        it 'should create the contribution' do
          expect(subject).to_not be_nil
        end


        it 'should assign the reward the contribution' do
          expect(subject.reward).to eq reward
        end

        it 'should set the payment method ' do
          expect(subject.payment_method).to eq 'PrePopulate'
        end

        it 'should set the contribution as confirmed' do
          expect(subject.confirmed?).to be_true
        end

        it 'should set the contribution as anonymous' do
          expect(subject.anonymous).to be_true
        end

        it{ should redirect_to populate_contribution_project_path(project) }
      end

      context 'existing user' do
        before do
          post :populate, id: project, user: { id: admin.id }, contribution: { reward_id: reward.id, value: reward.minimum_value, anonymous: true }
        end

        it_behaves_like 'create the contribution'

        it 'should assign the user to the contribution' do
          expect(project.contributions.first.user).to eq admin
        end
      end

      context 'new user' do
        before do
          post :populate, id: project, user: { name: 'New user', profile_type: 'organization' }, contribution: { reward_id: reward.id, value: reward.minimum_value, anonymous: true }
        end

        it_behaves_like 'create the contribution'

        context 'create the user' do
          subject { project.contributions.first.user }

          it 'should create the iser' do
            expect(subject).to_not be_nil
          end

          it 'should set the user name' do
            expect(subject.name).to eq 'New user'
          end

          it 'should create an email with populate.user' do
            expect(subject.email).to match(/@populate.user/)
          end
        end
      end

      context 'with error' do
        before do
          post :populate, id: project, user: { }, contribution: { }
        end

        it{ should render_template 'populate_contribution' }
      end
    end
  end

end

