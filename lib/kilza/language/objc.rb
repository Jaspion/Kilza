require 'date'

module Kilza
  class Objc
    class Class
      include Kilza::Class

      def sources
        [code('objc', 'h'), code('objc', 'm')]
      end
    end
  end
end

module Kilza
  # Objective-C Language parser
  class Objc
    include Kilza::Language

    def initialize(json_string)
      super(json_string)

      @reserved_delimiter = '_my'

      @reserved_words = %w(
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
      Kilza::Objc::Class.new(name)
    end

    def classes(class_name)
      super(class_name)

      @classes.each do |cl|
        cl.properties.each do |pr|
          if pr.object? || (pr.array? && pr.null?)
            pr.type = pr.name.capitalize + ' *'
            cl.imports.push("#import \"#{pr.name.capitalize}.h\"")
          end

          pr.type = 'NSMutableArray *' if pr.array?
          pr.type = @types[pr.type] unless @types[pr.type].nil?
        end
      end
    end
  end
end
