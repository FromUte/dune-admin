require 'spec_helper'

describe Dune::Admin::UserConcern do
  subject { User }

  describe ".by_email" do
    before do
      @u = create(:user, email: 'foo@bar.com')
      create(:user, email: 'another_email@bar.com')
    end
    subject{ User.by_email 'foo@bar' }
    it{ should == [@u] }
  end

  describe ".by_name" do
    before do
      @u = create(:user, name: 'Foo Bar')
      create(:user, name: 'Baz Qux')
    end
    subject{ User.by_name 'Bar' }
    it{ should == [@u] }
  end

  describe ".by_id" do
    before do
      @u = create(:user)
      create(:user)
    end
    subject{ User.by_id @u.id }
    it{ should == [@u] }
  end

  describe ".by_key" do
    before do
      b = create(:contribution)
      @u = b.user
      b.key = 'abc'
      b.save!
      b = create(:contribution, user: @u)
      b.key = 'abcde'
      b.save!
      b = create(:contribution)
      b.key = 'def'
      b.save!
    end
    subject{ User.by_key 'abc' }
    it{ should == [@u] }
  end

  describe ".has_credits" do
    subject{ User.has_credits }
    let(:failed_project){ create(:project, state: 'online') }
    let(:successful_project){ create(:project, state: 'online') }

    context "when he has credits in the user_total" do
      before do
        b = create(:contribution, state: 'confirmed', value: 100, project: failed_project)
        failed_project.update_attributes state: 'failed'
        @u = b.user
        b = create(:contribution, state: 'confirmed', value: 100, project: successful_project)
      end
      it{ should == [@u] }
    end
  end
end
