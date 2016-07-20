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
      TYPES = {
        'nilclass'    => 'id',
        'string'      => 'NSString *',
        'fixnum'      => 'NSNumber *',
        'float'       => 'NSNumber *',
        'falseclass'  => 'NSNumber *',
        'trueclass'   => 'NSNumber *',
        'hash'        => 'NSObject *'
      }

      def initialize(json_string)
        super(json_string)

        @equal_keys = %w(id identifier uid)
      end

      def clazz(name)
        Jaspion::Kilza::Objc::Class.new(name)
      end

      def property(name, type, array, key)
        Jaspion::Kilza::Objc::Property.new(name , type, array, key)
      end
    end
  end
end
