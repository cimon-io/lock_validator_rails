module ModelExtension
  def method_missing(method_name, *arguments, &block)
    /\A(?<name>.+)_lock=?\z/ =~ method_name.to_s
    return super if !name

    self.class.send(:attr_accessor, :"#{name}_lock")
    public_send(method_name, *arguments, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    /\A(?<name>.+)_lock=?\z/ =~ method_name.to_s
    return true if name && respond_to?(name)
    super
  end
end
