require 'date'

module Kilza
  class Java

    class Class
      include Kilza::Class

      attr_accessor :package

      def initialize(name, package = nil)
        super(name)
        @package = package
      end

      def sources
        cur_path = File.expand_path(__FILE__)
        java_path = File.join(File.dirname(cur_path), File.basename(cur_path, '.rb'), "java.erb")
        eruby_java = Erubis::Eruby.new(File.read(java_path))

        java = Kilza::Source.new
        java.source = eruby_java.result(binding)
        java.file_name = @name.capitalize + ".java"

        result = [
          java
        ]
        return result
      end
    end

  end
end

module Kilza
  class Java
    include Kilza::Language

    def initialize(json_string)
      super(json_string)

      @reserved_words = [
        "abstract", "continue", "for", "new", "switch", "assert", "default", "goto",
        "package", "synchronized", "boolean", "do", "if", "private", "this", "break", "double", "implements",
        "protected", "throw", "byte", "else", "import", "public", "throws", "case", "enum", "instanceof",
        "null", "return", "transient", "catch", "extends", "int", "short", "try", "char", "final", "interface", "static",
        "void", "class", "finally", "long", "strictfp", "volatile", "const", "float", "native", "super", "while"
      ]

      @types = {
        "nilclass" => "Object",
        "string" => "String",
        "fixnum" => "Long",
        "float" => "Double",
        "falseclass" => "Boolean",
        "trueclass" => "Boolean",
        "object" => "Object"
      }

      @equal_keys = [
        "id",
        "identifier",
        "uid"
      ]
    end

    def get_class(name)
      Kilza::Java::Class.new(name)
    end

    def parse(hash, class_name)
      super(hash, class_name)

      @classes.each { |cl|
        cl.properties.each { |pr|
          if pr.is_object?
            pr.type = pr.name.capitalize
          end

          if pr.is_array?
            cl.imports.push("import java.util.ArrayList;") if cl.imports.index("import java.util.ArrayList;").nil?
          end

          pr.type = @types[pr.type] if not @types[pr.type].nil?
        }
      }
    end

  end
end
