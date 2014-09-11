require 'active_null/version'
require 'active_null/null_model_builder'

module ActiveNull
  def null
    @null_class.get
  end

  def null_model(&block)
    null_model_overrides = if block_given?
      Module.new.tap { |m| m.module_eval(&block) }
    end
    @null_class = NullModelBuilder.new(self, null_model_overrides).build
  end

  def find_by(*args, &block)
    super || null
  end

  def null_associations
    self.reflect_on_all_associations.each do |relation|
      unless relation.collection?
        class_eval <<-CODE
          def #{relation.name}(*args)
            result = association(:#{relation.name}).reader(*args)
            return result if result || !#{relation.klass.name}.respond_to?(:null)
            #{relation.klass.name}.null
          end
        CODE
      end
    end
  end

  def self.extended(klass)
    klass.class_eval <<-CODE
      after_initialize do
        self.class.null_associations
      end
    CODE
  end
end
