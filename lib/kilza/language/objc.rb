require 'date'

module Kilza
  class Objc

    class Class
      include Kilza::Class

      def sources
        cur_path = File.expand_path(__FILE__)
        m_path = File.join(File.dirname(cur_path), File.basename(cur_path, '.rb'), "m.erb")
        h_path = File.join(File.dirname(cur_path), File.basename(cur_path, '.rb'), "h.erb")

        eruby_m = Erubis::Eruby.new(File.read(m_path))
        eruby_h = Erubis::Eruby.new(File.read(h_path))

        m = Kilza::Source.new
        m.source = eruby_m.result(binding)
        m.file_name = @name.capitalize + ".m"

        h = Kilza::Source.new
        h.source = eruby_h.result(binding)
        h.file_name = @name.capitalize + ".h"

        result = [
          h,m
        ]
        return result
      end
    end

  end
end

module Kilza
  class Objc
    include Kilza::Language

    def initialize(json_string)
      super(json_string)

      @reserved_words = [
        "auto", "break", "case", "char", "const", "continue",
        "class", "default", "do", "double", "else", "enum", "extern", "float", "for",
        "goto", "if", "id", "implementation", "inline", "int", "interface", "long",
        "nonatomic", "property", "protocol", "readonly", "readwrite", "register",
        "restrict", "retain", "return", "short", "signed", "sizeof", "static", "strong",
        "struct", "switch", "typedef", "union", "unsafe_unretained", "unsigned", "void",
        "volatile", "weak", "while", "_bool", "_complex", "_imaginary", "sel", "imp",
        "bool", "nil", "yes", "no", "self", "super", "__strong", "__weak", "oneway",
        "in", "out", "inout", "bycopy", "byref"
      ]

      @types = {
        "nilclass" => "id",
        "string" => "NSString *",
        "fixnum" => "NSNumber *",
        "float" => "NSNumber *",
        "falseclass" => "NSNumber *",
        "trueclass" => "NSNumber *",
        "object" => "NSObject *"
      }

      @equal_keys = [
        "id",
        "identifier",
        "uid"
      ]
    end

    def get_class(name)
      Kilza::Objc::Class.new(name)
    end

    def parse(hash, class_name)
      super(hash, class_name)

      @classes.each { |cl|
        cl.properties.each { |pr|
          if pr.is_object?
            cl.imports.push("#import \"" + pr.name.capitalize + ".h\"")
          end

          if pr.is_array?
            pr.type = "NSMutableArray *"
          end

          pr.type = @types[pr.type] if not @types[pr.type].nil?
        }
      }
    end

  end
end
