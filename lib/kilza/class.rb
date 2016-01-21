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

    # Initializes a Class object
    #
    # @param name [String] Class Name
    def initialize(name)
      @name = Kilza.normalize(name).capitalize
      @properties = []
      @imports = []
    end

    # Adds a new property
    #
    # @param property [Kilza::Property] Property to include
    def push(property)
      index = @properties.index(property)
      if !index.nil?
        current = @properties[index]
        @properties[index] = update(current, property)
      else
        @properties.push(property)
      end
    end

    def sources
      fail 'It should be implemented'
    end

    # Returns the #Source object of this Class.
    #
    # @param lang [String] Language name (java, objc, ...)
    # @param file_name [String] Source file name
    #
    # @return [Kilza::Source] Source object of this Class
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

    protected

    # Compares two properties and fill the src property with relevant
    # dst property values. If src.type is nilclass and dst.type not, replaces
    # it with dst.type
    #
    # @param property [Kilza::Property] Property to include
    #
    # @return [Kilza::Property] src property with new values
    def update(src, dst)
      src.type = dst.type if src.null? && !dst.null?
      src.original_type = dst.original_type if src.null? && !dst.null?
      src.array = dst.array unless src.array?
      src.key = dst.key unless src.key
      src
    end
  end
end
