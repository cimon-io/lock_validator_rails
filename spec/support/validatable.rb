require 'active_model/model'
require 'active_model/validations'
require 'lock_validator_rails'

class Validatable
  include ActiveModel::Model
  include ActiveModel::Validations
  include LockValidatorRails

  attr_accessor :updated_at

  validates :updated_at, lock: true

  def self.after_save(*args)
    true
  end
end
