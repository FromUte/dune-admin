require 'spec_helper'

describe Dune::Admin::ProjectConcern do
  subject { Project }

  describe '.by_progress' do
    subject { Project.by_progress(20) }

    before do
      @project_01 = create(:project, goal: 100)
      @project_02 = create(:project, goal: 100)
      @project_03 = create(:project, goal: 100)

      create(:contribution, value: 10, project: @project_01)
      create(:contribution, value: 10, project: @project_01)
      create(:contribution, value: 30, project: @project_02)
      create(:contribution, value: 10, project: @project_03)
    end

    it { should have(2).itens }
  end

  describe '.goal_between' do
    let(:start_at) { 100 }
    let(:ends_at) { 200 }
    subject { Project.goal_between(start_at, ends_at).order('goal asc') }

    before do
      @project_01 = create(:project, goal: 100)
      @project_02 = create(:project, goal: 200)
      @project_03 = create(:project, created_at: 300)
    end

    it { expect(subject.to_a).to eq [@project_01, @project_02] }
  end


  describe '.between_expires_at' do
    let(:start_at) { '17/01/2013' }
    let(:ends_at) { '21/01/2013' }
    subject { Project.between_expires_at(start_at, ends_at).order("id desc") }

    let(:project_01) { create(:project) }
    let(:project_02) { create(:project) }
    let(:project_03) { create(:project) }

    before do
      project_01.update_attributes({ online_date: '17/01/2013'.to_time, online_days: 0 })
      project_02.update_attributes({ online_date: '21/01/2013'.to_time, online_days: 0 })
      project_03.update_attributes({ online_date: '23/01/2013'.to_time, online_days: 0 })
    end

    it { should == [project_02, project_01] }
  end

end
