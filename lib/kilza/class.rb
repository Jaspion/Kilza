module Kilza
  # Represents one single object class
  module Class
    # Class name
    attr_accessor :name

    # Array with all class dependecies
    # Specific for each language
    attr_accessor :imports

    # Array with all class properties
    attr_accessor :properties

    def initialize(name)
      @name = Kilza.normalize(name).capitalize
      @properties = []
      @imports = []
    end

    # Search for a property by name
    #
    # @param name [String] Property name
    #
    # @return [Kilza::Property] The property found or nil
    def find(name)
      @properties.each { |p| return p if p.name == name }
      nil
    end

    # Adds a new property
    #
    # @param property [Kilza::Property] Property to include
    def push(property)
      p = find(property.name)
      @properties.push(property) if p.nil?
    end

    def sources
      fail 'It should be implemented'
    end

    def code(lang, file_name)
      cur_path = File.expand_path(__FILE__)
      erb_path = File.join(File.dirname(cur_path), 'language', lang)

      path = File.join(erb_path, file_name + '.erb')
      eruby = Erubis::Eruby.new(File.read(path))

      s = Kilza::Source.new
      s.source = eruby.result(binding)
      s.file_name = @name.capitalize + '.' + file_name
      s
    end

    def to_s
      properties = []
      @properties.each { |p| properties.push(p.to_s) }
      {
        name: @name,
        imports: @imports,
        properties: properties
      }.to_s
    end
  end
end
