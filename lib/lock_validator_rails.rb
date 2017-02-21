require 'lock_validator_rails/version'
require 'active_record'

module LockValidatorRails
  class LockValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << (options[:message] || 'wrong email address')
    end
  end
end
