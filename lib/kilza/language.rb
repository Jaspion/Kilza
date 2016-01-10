require 'json'
require 'erubis'

module Kilza
  module Language
    attr_accessor :classes
    attr_accessor :base_name
    attr_accessor :json_string

    attr_accessor :reserved_words # words that will receive an undescore before property name
    attr_accessor :equal_keys     # array with all properties that will be used to compare other objects
    attr_accessor :types          # hash table with all language types mapped to target language

    def initialize(json_string)
      @json_string = json_string
      @classes = []
      @types = {}
      @reserved_words = []
      @equal_keys = []
    end

    # Creates a new Class object and checks for valid name
    #
    # @param name [String] name of the class to be created
    # @return [Kilza::Class] new class
    def get_class(name)
      name = "_" + name if not @reserved_words.index(name).nil?
      Class.new(name)
    end

    # Creates a new Property object and checks for valid name
    #
    # @param name [String] name of the property to be created
    # @param type [String] type of the property based on class name
    # @param is_array [Boolean] indicates if this property represents an array
    # @param is_key [Boolean] indicates if this property can be used to compare objects
    # @return [Kilza::Property] new property
    def get_property(name, type, is_array, is_key)
      name = "_" + name if not @reserved_words.index(name).nil?
      Property.new(name, type, is_array, is_key.nil?)
    end

    # Searches for a Kilza::Class inside @classes
    # and creates a new one if could not be found
    #
    # @param name [String] class name to find
    # @return [Kilza::Class] class with the specified name
    def find(name)
      @classes.each { |cl|
        return cl if (cl.name == name)
      }
      @classes.push(get_class(name))
      return @classes.last
    end

    # Traverses each element inside a hash
    # Transform each hash into Kilza::Class
    # Trasnform each element into Kilza::Property
    # It build the @classes property
    #
    # @param hash [Hash] hash to be parsed
    # @param class_name [String] class name that represents the hash
    # @return
    def parse(hash, class_name)
      current_class = find(class_name)
      hash.each { |property_name, value|
        type = value.class.name.split('::').last.downcase

        case type
        when "array"
          if (value.length == 0)
            current_class.push(get_property(property_name, 'object', true, @equal_keys.index(property_name)))
            parse(value, property_name)
          else
            value.each { |el|
              if (el.is_a?(Array) or el.is_a?(Hash))
                parse(el, property_name)
                current_class.push(get_property(property_name, 'object', true, @equal_keys.index(property_name)))
              else
                type = el.class.name.split('::').last.downcase
                current_class.push(get_property(property_name, type, true, @equal_keys.index(property_name)))
              end
            }
          end
        when "hash"
          current_class.push(get_property(property_name, 'object', false, @equal_keys.index(property_name)))
          parse(value, property_name)
        else
          current_class.push(get_property(property_name, type, false, @equal_keys.index(property_name)))
        end
      }
    end

    def classes(base_name)
      hash = JSON.parse(json_string)
      if (hash.is_a?(Array))
        hash = { base_name + "Object" => hash }
      end
      parse(hash, base_name)
      return @classes
    end

  end
end
