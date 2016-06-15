module Jaspion
  module Kilza
    class Swift
      class Class
        include Jaspion::Kilza::Class

        def initialize(name)
          super(name)
          @name = @name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
        end

        def sources
          [code('swift', 'swift')]
        end
      end
    end
  end
end
