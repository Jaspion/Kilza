require 'json'
require 'erubis'

module Jaspion
  module Kilza
    # Represents an program language
    module Language
      # Array with all Class classes
      attr_accessor :classes

      # Name used to represent the first generated class
      attr_accessor :base_name

      # JSON that will be used to generate objects
      attr_accessor :json_string

      # Words that will receive an undescore before property name
      attr_accessor :reserved_words

      # Array with all properties that will be used to compare other objects
      attr_accessor :equal_keys

      # Hash table with all language types mapped to target language
      attr_accessor :types

      # Initializes the language
      # If json_string is not a Hash {}, it will surroud the json with
      # { "base_name"} = json_string
      #
      # @param json_string [String] JSON String
      #
      def initialize(json_string)
        @json_string = json_string
        @classes = []
        @types = {}
        @reserved_words = []
        @equal_keys = []
      end

      # Returns all available classes
      #
      # @param base_name [String] First class name
      #
      # @return [Array] All available classes
      def classes(base_name)
        @classes = []
        hash = JSON.parse(json_string)
        hash = { base_name + 'Object' => hash } if hash.is_a?(Array)
        parse_hash(base_name, hash)

        @classes
      end

      protected

      # Creates a new Class object and checks for valid name
      #
      # @param name [String] name of the class to be created
      #
      # @return [Kilza::Class] new class
      def clazz(name)
        # cl_name = self.class.name.split('::').last
        # cl = Jaspion::Kilza.const_get("#{cl_name}::Class")
        # return cl.new(name) unless cl.nil?
        #
        Class.new(name)
      end

      # Creates a new Property object and checks for valid name
      #
      # @param name [String] name of the property to be created
      # @param type [String] type of the property based on class name
      # @param array [Boolean] indicates if this property represents an array
      # @param key [Boolean] indicates if this property can be used to compare
      # objects
      #
      # @return [Kilza::Property] new property
      def property(name, type, array, key)
        original_name = name
        prop = Property.new(name , type, array, key)
        prop.original_name = original_name
        prop
      end

      # Searches for a Kilza::Class inside @classes
      # and creates a new one if it could not be found
      #
      # @param name [String] class name to find
      #
      # @return [Kilza::Class] class with the specified name
      def find(name)
        name = Jaspion::Kilza::Class::normalize(name)

        @classes.each { |cl| return cl if cl.name == name }
        @classes.push(clazz(name))
        @classes.last
      end

      # Parses an element value an verify if it should create a new Classs
      # inside @classes
      #
      # @param class_name [String] Name of the class the element is inside
      # @param name [String] The element name
      # @param value [Any] The element value
      # @param array [Boolean] Indicates the element is inside an Array
      def parse_el(class_name, name, value, array = false)
        type = value.class.name.split('::').last.downcase

        return parse_array(class_name, name, value) if type == 'array'

        cur_class = find(class_name)
        key = @equal_keys.index(name).nil? ? false : true
        cur_class.push(property(name, type, array, key))

        # if value is nil, consider it as an Object
        find(name) if type == 'nilclass'

        parse_hash(name, value) if type == 'hash'
      end

      # Parses an hash calling parse_el for each element
      #
      # @param class_name [String] Name of the class the hash is inside
      # @param hash [Hash] The hash value
      def parse_hash(class_name, hash)
        hash.each do |property_name, value|
          parse_el(class_name, property_name, value)
        end
      end

      # Parses an element that represents an array calling parse_el
      # for each element.
      # If the array is empty, it creates a new class to represent
      # each array's element.
      #
      # @param class_name [String] Name of the class the array is inside
      # @param name [String] The element name
      # @param value [Any] The element value
      def parse_array(class_name, name, value)
        if value.length == 0
          parse_el(class_name, name, nil, true)
        else
          value.each do |val|
            parse_el(class_name, name, val, true)
          end
        end
      end
    end
  end
end
