require 'spec_helper'

describe LockValidatorRails do
  let(:updated_at) { Time.new(2017, 1, 2, 11, 30, 25) }
  let(:errors) { double(:errors).as_null_object }
  subject { Validatable.new(lock_value: lock_value, updated_at: updated_at) }

  context 'version number' do
    it { expect(LockValidatorRails::VERSION).not_to be_nil }
  end

  context 'when :lock_value is equal to normalized :updated_at' do
    let(:lock_value) { '1483349425000000' }
    it { is_expected.to be_valid }
  end

  context 'when :lock_value is different from normalized :updated_at' do
    let(:lock_value) { '1483349425000001' }
    it { is_expected.not_to be_valid }

    it 'adds error to record' do
      allow(subject).to receive(:errors).and_return(errors)
      expect(errors).to receive(:add).with(:lock_value, :outdated, message: :is_outdated)
      subject.valid?
    end
  end
end
