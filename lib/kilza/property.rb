module Kilza
  class Property
    attr_accessor :name
    attr_accessor :original_name
    attr_accessor :type
    attr_accessor :params
    attr_accessor :is_array
    attr_accessor :is_key

    def initialize(name, type, is_array, is_key)
      @name = Kilza::normalize(name)
      @original_name = name
      @type = type
      @is_array = is_array
      @is_key = is_key
    end

    def is_array?
      @is_array
    end

    def is_object?
      @type == 'object' or @type == @name.capitalize
    end

    def is_fixnum?
      @type == 'fixnum'
    end

    def is_boolean?
      @type == 'trueclass' or @type == 'falseclass'
    end

    def is_float?
      @type == 'float'
    end

    def is_nil?
      @type == 'nilclass'
    end

    def to_hash
      hash = {
        :name => @name,
        :original_name => @original_name,
        :type => @type,
        :params => @params,
        :is_array? => @is_array,
        :is_object? => is_object?,
        :is_fixnum? => is_fixnum?,
        :is_boolean? => is_boolean?,
        :is_float? => is_float?,
        :is_nil? => is_nil?
      }
      hash
    end
  end
end
