require 'date'

module Jaspion
  module Kilza
    # Objective-C Language parser
    class Java
      include Jaspion::Kilza::Language

      RESERVED_PROPERTY_PREFIX = '_'
      RESERVED_CLASS_POSFIX = 'Class'
      RESERVED_WORDS = %w(
        abstract continue for new switch assert default goto,
        package synchronized boolean do if private this break double implements,
        protected throw byte else import public throws case enum instanceof,
        null return transient catch extends int short try char final interface static,
        void class finally long strictfp volatile const float native super while
      )
      TYPES = {
        'nilclass'    => 'Object',
        'string'      => 'String',
        'fixnum'      => 'Long',
        'float'       => 'Double',
        'falseclass'  => 'Boolean',
        'trueclass'   => 'Boolean',
        'hash'        => 'Object'
      }

      def initialize(json_string)
        super(json_string)

        @equal_keys = %w(id identifier uid)
      end

      def clazz(name)
        Jaspion::Kilza::Java::Class.new(name)
      end

      def property(name, type, array, key)
        Jaspion::Kilza::Java::Property.new(name , type, array, key)
      end
    end
  end
end
