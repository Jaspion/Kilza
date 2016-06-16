require 'jaspion/kilza/language/swift/class'

module Jaspion
  module Kilza
    class Swift
      class Property < Jaspion::Kilza::Property
        def class_name
          return if !(object? || null? || (array? && null?))

          class_name = super
          class_name = class_name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(class_name.downcase).nil?
          class_name
        end

        def constants(cl_name)
          "    static let k#{cl_name}#{@name.capitalize}: String = \"#{@original_name.gsub('"', '\"')}\""
        end

        def declaration
          "    public var #{@name}: #{@type}?"
        end

      end
    end
  end
end
