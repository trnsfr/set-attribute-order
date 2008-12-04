module SetAttributeOrder
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    attr_reader :attribute_ordered_array
    
    def set_attribute_order(*attrs)
      @attribute_ordered_array = attrs
    end
  end
  
  
  def initialize(attrs={})
    order = self.class.attribute_ordered_array
    return super if order.empty?
    ordered = attrs.sort_by {|k, v| order.index(k.to_sym) || 0 }
    ordered.each{ |k,v| self.send(:"#{k}=", v) }
    attrs.reject!{ |k,v| order.include?(k.to_sym) }
    super
  end
  
end
