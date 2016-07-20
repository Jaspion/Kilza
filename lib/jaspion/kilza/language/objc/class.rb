module Jaspion
  module Kilza
    class Objc
      class Class
        include Jaspion::Kilza::Class

        def initialize(name)
          name = name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
          super(name)
        end

        def push(pr)
          if pr.object? || (pr.array? && pr.null?)
            pr.type = pr.class_name + ' *'
            push_import("#import \"#{pr.class_name}.h\"")
          end

          pr.type = 'NSMutableArray *' if pr.array?
          unless Jaspion::Kilza::Objc::TYPES[pr.type].nil?
            pr.type = Jaspion::Kilza::Objc::TYPES[pr.type]
          end

          super(pr)
        end

        def imports
          @imports.sort.flatten
        end

        def equals
          r = StringIO.new
          r << '- (BOOL)isEqual:(id)anObject {'
          fields = []
          for pr in @properties
              fields.push("[((#{@name}) anObject).#{pr.name} isEqual:#{pr.name}]") if pr.key?
          end
          r << "\n    if (anObject instanceof #{@name}) {"
          r << "        return (" + fields.join(" &&\n            ") + "});"
          r << "\n    }"
          r << "\n    return false;"
          r << "\n}"
          r.string
        end

        def sources
          [code('objc', 'h'), code('objc', 'm')]
        end
      end
    end
  end
end
