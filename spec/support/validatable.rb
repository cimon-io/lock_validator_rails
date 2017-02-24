class Validatable
  include ActiveModel::Model
  include ActiveModel::Validations
  include LockValidatorRails

  attr_accessor :updated_at, :updated_at_lock

  validates :updated_at, lock: true
end
