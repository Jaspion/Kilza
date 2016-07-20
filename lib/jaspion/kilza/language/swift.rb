require 'date'

module Jaspion
  module Kilza
    # Swift Language parser
    class Swift
      include Jaspion::Kilza::Language

      RESERVED_PROPERTY_PREFIX = '_'
      RESERVED_CLASS_POSFIX = 'Class'
      RESERVED_WORDS = %w(
        class break as associativity deinit case dynamicType
        convenience enum continue false dynamic extension default
        is didSet func do nil final import else self get init
        fallthrough Self infix internal for super inout let
        if true lazy operator in left private return mutating
        protocol switch none public where nonmutating static
        while optional struct override subscript postfix
        typealias precedence var prefix required right set
        type unowned weak id description
      )
      TYPES = {
        'nilclass'    => 'AnyObject',
        'string'      => 'String',
        'fixnum'      => 'Int',
        'float'       => 'Double',
        'falseclass'  => 'Bool',
        'trueclass'   => 'Bool',
        'hash'        => 'Dictionary'
      }

      def initialize(json_string)
        super(json_string)

        @equal_keys = 'id identifier uid'
      end

      def clazz(name)
        Jaspion::Kilza::Swift::Class.new(name)
      end

      def property(name, type, array, key)
        Jaspion::Kilza::Swift::Property.new(name , type, array, key)
      end
    end
  end
end
