require 'date'

module Jaspion
  module Kilza
    class Swift
      class Class
        include Jaspion::Kilza::Class

        def sources
          [code('swift', 'swift')]
        end
      end
    end
  end
end

module Jaspion
  module Kilza
    # Swift Language parser
    class Swift
      include Jaspion::Kilza::Language

      def initialize(json_string)
        super(json_string)

        @reserved_delimiter = '_my'

        @reserved_words = %w(
          class break as associativity deinit case dynamicType
          convenience enum continue false dynamic extension default
          is didSet func do nil final import else self get init
          fallthrough Self infix internal for super inout let
          if true lazy operator in left private return mutating
          protocol switch none public where nonmutating static
          while optional struct override subscript postfix
          typealias precedence var prefix required right set
          type unowned weak id
        )

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
        Jaspion::Kilza::Swift::Class.new(name)
      end

      def classes(class_name)
        super(class_name)

        @classes.each do |cl|
          cl.properties.each do |pr|
            if pr.object? || (pr.array? && pr.null?)
              pr.type = pr.name.capitalize
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
