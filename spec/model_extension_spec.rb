require 'spec_helper'

describe ModelExtension do
  let(:updated_at) { '1483349425000000' }
  let(:updated_at_lock) { updated_at }
  let(:instance) { Validatable.new(updated_at_lock: updated_at_lock, updated_at: updated_at) }

  context 'dynamic definition of getter and setter' do
    subject { instance }

    it 'defines #<attribute>_lock' do
      is_expected.to respond_to(:updated_at_lock)
      is_expected.not_to respond_to(:saved_at_lock)
      expect(subject.updated_at_lock).to eq(updated_at_lock)
    end

    it 'defines #<attribute>_lock=' do
      is_expected.to respond_to(:updated_at_lock=)
      is_expected.not_to respond_to(:saved_at_lock=)
      subject.updated_at_lock = '123'
      expect(subject.updated_at_lock).to eq('123')
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
