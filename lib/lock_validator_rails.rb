require 'lock_validator_rails/version'
require 'active_record'

module LockValidatorRails
  class LockValidator < ActiveModel::EachValidator

    def initialize(options)
      options[:message] ||= :is_outdated
      options[:with] ||= :updated_at
      options[:normalizer] ||= :to_microseconds
      super
    end

    def validate_each(record, attribute, value)
      return if record.public_send(options[:normalizer], options[:with]) == value
      error_key = options.fetch(:error_key, attribute)
      record.errors.add(error_key, :outdated, message: options[:message])
    end
  end
end
