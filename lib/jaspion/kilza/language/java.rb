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

      def initialize(json_string)
        super(json_string)

        @types = {
          'nilclass' => 'Object',
          'string' => 'String',
          'fixnum' => 'Long',
          'float' => 'Double',
          'falseclass' => 'Boolean',
          'trueclass' => 'Boolean',
          'hash' => 'Object'
        }

        @equal_keys = %w(id identifier uid)
      end

      def clazz(name)
        Jaspion::Kilza::Java::Class.new(name)
      end

      def property(name, type, array, key)
        original_name = name
        name = RESERVED_PROPERTY_PREFIX + name unless RESERVED_WORDS.index(name).nil?
        prop = Jaspion::Kilza::Java::Property.new(name , type, array, key)
        prop.original_name = original_name
        prop
      end

      def classes(class_name)
        super(class_name)

        @classes.each do |cl|
          cl.properties.each do |pr|
            pr.type = pr.class_name if pr.object? || (pr.array? && pr.null?)

            cl.push_import('import java.util.ArrayList;') if pr.array? &&
              cl.imports.index('import java.util.ArrayList;').nil?

            pr.type = @types[pr.type] unless @types[pr.type].nil?
          end
        end
      end
    end
  end
end
