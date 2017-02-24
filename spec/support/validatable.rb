class Validatable
  include ActiveModel::Model
  include ActiveModel::Validations
  include LockValidatorRails

  attr_accessor :updated_at

  validates :updated_at, lock: true
end
