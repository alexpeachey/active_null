require 'naught'

module ActiveNull
  class NullModelBuilder
    attr_reader :model, :overrides

    def initialize(model, overrides)
      @model = model
      @overrides = overrides
    end

    def build
      model = self.model
      return full_name.constantize if Object.const_defined? full_name
      null = Naught.build do |config|
        config.impersonate model

        model.reflect_on_all_associations.each do |relation|
          if relation.collection?
            define_method(relation.name) { [] }
          else
            define_method(relation.name) do
              return unless relation.klass.respond_to? :null
              relation.klass.null
            end
          end
        end

        model.column_defaults.each do |field, default|
          define_method(field.to_sym) { default }
        end

        def nil?
          true
        end

        def present?
          false
        end

        def blank?
          true
        end

        def to_json
          '{}'
        end
      end
      null.class_eval { include Draper::Decoratable } if Object.const_defined? 'Draper'
      null.include(overrides) if overrides
      set_null_model null
    end

    def name
      base_name = model.name.split('::').last
      "Null#{base_name}"
    end

    def full_name
      return name if model.parent == Object
      "#{model.parent.name}::#{name}"
    end

    def set_null_model(null)
      model.parent.const_set name, null
    end
  end
end
