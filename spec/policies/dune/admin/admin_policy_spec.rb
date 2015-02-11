require 'spec_helper'

describe Dune::Admin::AdminPolicy do
  subject { described_class }

  permissions :access? do
    it 'denies access if user is nil' do
      expect(subject).not_to permit(nil, Dune::Admin)
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(User.new, Dune::Admin)
    end

    it 'permits access if user is admin' do
      user = User.new
      user.admin = true
      expect(subject).to permit(user, Dune::Admin)
    end
  end
end

