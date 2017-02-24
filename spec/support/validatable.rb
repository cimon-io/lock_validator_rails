class Validatable
  include ActiveModel::Model
  include ActiveModel::Validations
  include LockValidatorRails

  attr_accessor :lock_value, :updated_at

  validates :lock_value, lock: true

  def to_microseconds(field)
    public_send(field).strftime('%s%6N')
  end
end
