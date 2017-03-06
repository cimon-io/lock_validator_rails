require 'spec_helper'

describe LockValidatorRails do
  before do
    allow(instance).to receive(:attribute_names).and_return([:updated_at])
    allow(instance).to receive(:changes).and_return({})
    allow(Validatable).to receive(:type_for_attribute).and_return(type_for_attribute)
    allow(type_for_attribute).to receive(:deserialize).and_return(:deserialized_value)
  end

  let(:updated_at) { Time.now }
  let(:updated_at_lock) { updated_at }
  let(:instance) { Validatable.new(updated_at_lock: updated_at_lock, updated_at: updated_at) }
  let(:type_for_attribute) { double(:type_for_attribute) }

  context 'version number' do
    subject { LockValidatorRails::VERSION }

    it { is_expected.not_to be_nil }
  end

  context 'when :updated_at_lock is equal to :updated_at' do
    before { allow(type_for_attribute).to receive(:deserialize).and_return(updated_at) }
    subject { instance }

    it { is_expected.to be_valid }
  end

  context 'when :updated_at_lock is different from :updated_at' do
    subject { instance.errors }

    it { expect(instance).not_to be_valid }

    it 'adds error to record' do
      is_expected.to receive(:add).with(:base, :outdated)
      instance.valid?
    end

    context 'when :updated_at is changed from valid value' do
      before do
        allow(type_for_attribute).to receive(:deserialize).and_return(updated_at)
        allow(instance).to receive(:changes).and_return(updated_at: [updated_at, nil])
      end

      subject { instance }

      it { is_expected.to be_valid }
    end
  end
end
