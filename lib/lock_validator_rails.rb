require 'lock_validator_rails/version'
require 'active_record'
require 'model_extension'

module LockValidatorRails
  include ModelExtension

  class LockValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      compare = options.fetch(:compare, ->(_, value, lock) { value == lock })

      return if compare[record, value, record.public_send("#{attribute}_lock")]
      record.errors.add(:base, :outdated)
    end
  end
end

ActiveRecord::Base.send(:include, LockValidatorRails)
