module Kilza
  module Class
    attr_accessor :name
    attr_accessor :params
    attr_accessor :imports
    attr_accessor :properties

    def initialize(name)
      @name = Kilza::normalize(name).capitalize
      @properties = []
      @imports = []
      @params = []
    end

    def find(name)
      @properties.each { |p|
        return p if (p.name == name)
      }
      nil
    end

    def push(property)
      p = find(property.name)
      if p.nil?
        @properties.push(property)
      end
    end

    def sources
    end

    def to_hash
      properties = []
      @properties.each { |p|
        properties.push(p.to_hash)
      }
      hash = {
        :name => @name,
        :imports => @imports,
        :params => @params,
        :properties => properties
      }
      hash
    end
  end
end
