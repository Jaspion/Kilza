module Jaspion
  module Kilza
    class Objc
      class Property < Jaspion::Kilza::Property

        def initialize(name, type, array, key = '')
          original_name = name
          unless RESERVED_WORDS.index(name.downcase).nil?
            name = RESERVED_PROPERTY_PREFIX + name
          end
          super(name, type, array, key)
          @original_name = original_name
        end

        def class_name
          return if !(object? || (array? && null?))

          class_name = super
          class_name = class_name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(class_name.downcase).nil?
          class_name
        end

        def class_reference
          return "@class #{class_name};" unless class_name.nil? || array?
        end

        def declaration
          "@property (nonatomic, strong, nullable) #{@type} #{@name};"
        end

        def constants(cl_name)
          "NSString *const k#{cl_name}#{@name.capitalize} = @\"#{@original_name}\";"
        end

      end
    end
  end
end
