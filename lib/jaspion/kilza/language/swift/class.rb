module Jaspion
  module Kilza
    class Swift
      class Class
        include Jaspion::Kilza::Class

        def initialize(name)
          name = name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
          super(name)
        end

        def push(pr)
          if pr.object? || (pr.array? && pr.null?)
            pr.type = pr.class_name
            push_import("import #{pr.class_name}")
          end

          pr.type = Jaspion::Kilza::Swift::TYPES[pr.type] unless Jaspion::Kilza::Swift::TYPES[pr.type].nil?
          pr.type = "[#{pr.type}]" if pr.array?

          super(pr)
        end

        def sources
          [code('swift', 'swift')]
        end
      end
    end
  end
end
