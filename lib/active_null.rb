require 'active_null/version'
require 'active_null/null_model_builder'

module ActiveNull
  def null
    null_class.get
  end

  def null_defaults_for_polymorphic mappings
    @polymorphic_null_defaults = mappings
  end

  def polymorphic_null_defaults
    @polymorphic_null_defaults || {}
  end

  def null_model(method_name=nil, &block)
    @null_model_overrides = if block_given?
      Module.new.tap { |m| m.module_eval(&block) }
    end

    if method_name
      singleton_class.class_eval do
        define_method(method_name) { null }
      end
    end
  end

  def find_by(*args, &block)
    super || null
  end

  def null_associations
    self.reflect_on_all_associations.each do |relation|
      unless relation.collection?
        klass = begin
          if relation.options[:polymorphic]
            polymorphic_null_defaults[relation.name]
          elsif relation.klass
            relation.klass.name
          end
        rescue
          nil
        end
        next unless klass
        class_eval <<-CODE
          def #{relation.name}(*args)
            result = association(:#{relation.name}).reader(*args)
            return result if result || !#{klass}.respond_to?(:null)
            #{klass}.null
          end
        CODE
      end
    end
  end

  def null_class
    @null_class ||= NullModelBuilder.new(self, @null_model_overrides).build
  end

  def self.extended(klass)
    klass.class_eval <<-CODE
      after_initialize do
        self.class.null_associations
      end
    CODE
  end
end
