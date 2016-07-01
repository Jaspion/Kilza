require 'date'

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
              pr.type = pr.class_name + ' *'
              cl.push_import("#import \"#{pr.class_name}.h\"")
            end

            pr.type = 'NSMutableArray *' if pr.array?
            pr.type = @types[pr.type] unless @types[pr.type].nil?
          end
        end
      end
    end
  end
end
