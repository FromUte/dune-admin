require 'spec_helper'

describe Dune::Admin::ContributionConcern do
  describe '.between_values' do
    let(:start_at) { 10 }
    let(:ends_at)  { 20 }
    subject        { Contribution.between_values(start_at, ends_at) }

    before do
      create(:contribution, value: 10)
      create(:contribution, value: 15)
      create(:contribution, value: 20)
      create(:contribution, value: 21)
    end

    it { should have(3).itens }
  end
end

