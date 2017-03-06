require 'lock_validator_rails/version'
require 'active_record'
require 'model_extension'

module LockValidatorRails
  include ModelExtension

  class LockValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      compare = options.fetch(:compare, ->(record, attribute, value, lock) { value == lock || record.changes[attribute].try(:first) == lock })

      return if compare[record, attribute, value, record.public_send("#{attribute}_lock")]
      record.errors.add(:base, :outdated)
    end
  end
end

ActiveRecord::Base.send(:include, LockValidatorRails)
