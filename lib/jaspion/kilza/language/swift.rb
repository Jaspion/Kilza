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

      def initialize(json_string)
        super(json_string)

        @types = {
          'nilclass' => 'AnyObject',
          'string'  => 'String',
          'fixnum' => 'Int',
          'float' => 'Double',
          'falseclass' => 'Bool',
          'trueclass' => 'Bool',
          'hash' => 'Dictionary'
        }

        @equal_keys = 'id identifier uid'
      end

      def clazz(name)
        name = name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
        Jaspion::Kilza::Swift::Class.new(name)
      end

      def property(name, type, array, key)
        original_name = name
        name = RESERVED_PROPERTY_PREFIX + name unless RESERVED_WORDS.index(name.downcase).nil?
        prop = Jaspion::Kilza::Swift::Property.new(name , type, array, key)
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

              pr.type = name
              cl.imports.push("import #{pr.name.capitalize}")
            end

            pr.type = @types[pr.type] unless @types[pr.type].nil?
            pr.type = "[#{pr.type}]" if pr.array?
          end
        end
      end
    end
  end
end
