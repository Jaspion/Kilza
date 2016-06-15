require 'date'

module Jaspion
  module Kilza
    class Objc
      class Class
        include Jaspion::Kilza::Class

        def initialize(name)
          super(name)
          @name = @name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
        end

        def equals
          r = StringIO.new
          r << '- (BOOL)isEqual:(id)anObject {'
          fields = []
          for pr in @properties
              fields.push("[((#{@name}) anObject).#{pr.name} isEqual:#{pr.name}]") if pr.key?
          end
          r << "\n    if (anObject instanceof #{@name}) {"
          r << "        return (" + fields.join(" &&\n            ") + "});"
          r << "\n    }"
          r << "\n    return false;"
          r << "\n}"
          r.string
        end

        def sources
          [code('objc', 'h'), code('objc', 'm')]
        end
      end
    end
  end
end

module Jaspion
  module Kilza
    class Objc
      class Property < Jaspion::Kilza::Property

        def class_name
          return if !object?
          Jaspion::Kilza::Objc::Class.new(@original_name).name
        end

        def class_reference
          return "@class #{class_name};" unless class_name.nil? || array?
        end

        def declaration
          "@property (nonatomic, strong) #{@type} #{@name};"
        end

        def constants(cl_name)
          "NSString *const k#{cl_name}#{@name.capitalize} = @\"#{@original_name}\";"
        end

      end
    end
  end
end

module Jaspion
  module Kilza
    # Objective-C Language parser
    class Objc
      include Jaspion::Kilza::Language

      RESERVED_PROPERTY_PREFIX = '_'
      RESERVED_CLASS_POSFIX = 'Class'
      RESERVED_WORDS = %w(
        auto break case char const continue,
        class default do double else enum extern float for,
        goto if id implementation inline int interface long,
        new nonatomic property protocol readonly readwrite register,
        restrict retain return short signed sizeof static strong,
        struct switch typedef union unsafe_unretained unsigned void,
        volatile weak while _bool _complex _imaginary sel imp,
        bool nil yes no self super __strong __weak oneway,
        in out inout bycopy byref
      )

      def initialize(json_string)
        super(json_string)

        @types = {
          'nilclass' => 'id',
          'string'  => 'NSString *',
          'fixnum' => 'NSNumber *',
          'float' => 'NSNumber *',
          'falseclass' => 'NSNumber *',
          'trueclass' => 'NSNumber *',
          'hash' => 'NSObject *'
        }

        @equal_keys = %w(id identifier uid)
      end

      def clazz(name)
        name = name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
        Jaspion::Kilza::Objc::Class.new(name)
      end

      def property(name, type, array, key)
        original_name = name
        name = RESERVED_PROPERTY_PREFIX + name unless RESERVED_WORDS.index(name.downcase).nil?
        prop = Jaspion::Kilza::Objc::Property.new(name , type, array, key)
        prop.original_name = original_name
        prop
      end

      def classes(class_name)
        super(class_name)

        @classes.each do |cl|
          cl.properties.each do |pr|
            if pr.object? || (pr.array? && pr.null?)
              name = Kilza.clean(pr.original_name)
              name[0] = name[0].capitalize
              name = name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
              pr.type = name + ' *'
              cl.imports.push("#import \"#{name}.h\"")
            end

            pr.type = 'NSMutableArray *' if pr.array?
            pr.type = @types[pr.type] unless @types[pr.type].nil?
          end
        end
      end
    end
  end
end
