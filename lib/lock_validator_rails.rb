require 'lock_validator_rails/version'
require 'active_record'
require 'model_extension'

module LockValidatorRails
  include ModelExtension

  class LockValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      compare = options.fetch(:compare, ->(_, value, lock_value) { value == lock_value })
      return if compare[record, value, record.public_send("#{attribute}_lock")]

      record.changes.keys.each { |name| record.errors.add(name, :changed) }
      record.errors.add(:base, :outdated)
    end
  end
end
