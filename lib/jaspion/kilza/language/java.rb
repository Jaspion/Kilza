require 'date'

module Jaspion
  module Kilza
    class Java
      class Class
        include Jaspion::Kilza::Class

        # Represents the Java class package
        attr_accessor :package

        def initialize(name, package = nil)
          super(name)
          @package = package
        end

        def sources
          [code('java', 'java')]
        end
      end
    end
  end
end

module Jaspion
  module Kilza
    # Objective-C Language parser
    class Java
      include Jaspion::Kilza::Language

      def initialize(json_string)
        super(json_string)

        @reserved_words = %w(
          abstract continue for new switch assert default goto,
          package synchronized boolean do if private this break double implements,
          protected throw byte else import public throws case enum instanceof,
          null return transient catch extends int short try char final interface static,
          void class finally long strictfp volatile const float native super while
        )

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

      def classes(class_name)
        super(class_name)

        @classes.each do |cl|
          cl.properties.each do |pr|
            pr.type = pr.name.capitalize if pr.object? || (pr.array? && pr.null?)

            cl.imports.push('import java.util.ArrayList;') if pr.array? &&
              cl.imports.index('import java.util.ArrayList;').nil?

            pr.type = @types[pr.type] unless @types[pr.type].nil?
          end
        end
      end
    end
  end
end
