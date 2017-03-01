require 'spec_helper'

describe ModelExtension do
  before do
    allow(Validatable).to receive(:type_for_attribute).and_return(type_for_attribute)
    allow(type_for_attribute).to receive(:deserialize).and_return(:deserialized_value)
  end

  let(:updated_at) { Time.now }
  let(:updated_at_lock) { updated_at }
  let(:instance) { Validatable.new(updated_at_lock: updated_at_lock, updated_at: updated_at) }
  let(:type_for_attribute) { double(:type_for_attribute) }

  context 'dynamic definition of getter and setter' do
    subject { instance }

    it 'defines #<attribute>_lock' do
      is_expected.to respond_to(:updated_at_lock)
      is_expected.not_to respond_to(:saved_at_lock)
      expect(subject.updated_at_lock).to eq(:deserialized_value)
    end

    it 'defines #<attribute>_lock=' do
      is_expected.to respond_to(:updated_at_lock=)
      is_expected.not_to respond_to(:saved_at_lock=)
      subject.updated_at_lock = '123'
      expect(subject.updated_at_lock).to eq(:deserialized_value)
    end

    context '#method_missing' do
      it 'no attr_accessor call if super is called' do
        expect_any_instance_of(ActiveModel::Model).to receive(:method_missing).with(:user_id).once
        expect(instance).not_to receive(:attr_accessor)
        instance.user_id
      end
    end
  end
end
