require 'spec_helper'

describe LockValidatorRails do
  before do
    allow(instance).to receive(:attribute_names).and_return([:updated_at])
    allow(instance).to receive(:changes).and_return({})
  end

  let(:updated_at) { '1483349425000000' }
  let(:updated_at_lock) { updated_at }
  let(:instance) { Validatable.new(updated_at_lock: updated_at_lock, updated_at: updated_at) }

  context 'version number' do
    subject { LockValidatorRails::VERSION }

    it { is_expected.not_to be_nil }
  end

  context 'when :updated_at_lock is equal to :updated_at' do
    subject { instance }

    it { is_expected.to be_valid }
  end

  context 'when :updated_at_lock is different from :updated_at' do
    let(:updated_at_lock) { '1483349425000001' }
    subject { instance.errors }

    it { expect(instance).not_to be_valid }

    it 'adds error to record' do
      is_expected.to receive(:add).with(:base, :outdated)
      instance.valid?
    end
  end
end
