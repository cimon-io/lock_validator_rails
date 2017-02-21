require "spec_helper"

describe LockValidatorRails do
  context 'version number' do
    it { expect(LockValidatorRails::VERSION).not_to be_nil }
  end
end
