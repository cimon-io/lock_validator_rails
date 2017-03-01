module ModelExtension
  def method_missing(method_name, *arguments, &block)
    /\A(?<name>.+)_lock=?\z/ =~ method_name.to_s
    return super if !name

    define_lock_for(name)
    public_send(method_name, *arguments, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    /\A(?<name>.+)_lock=?\z/ =~ method_name.to_s
    return true if name && respond_to?(name)
    super
  end

  private

  def define_lock_for(name)
    lock = :"#{name}_lock"

    self.class.class_eval do
      attr_writer lock

      define_method(lock) do
        self.class
          .type_for_attribute(name)
          .deserialize(instance_variable_get("@#{lock}") || public_send(name))
      end

      after_save -> { public_send("#{lock}=", public_send(name)) }
    end
  end

end
