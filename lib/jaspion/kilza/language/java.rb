require 'date'

module Jaspion
  module Kilza
    class Java
      class Class
        include Jaspion::Kilza::Class

        # Represents the Java class package
        attr_accessor :package

        def initialize(name, package = nil)
          super(name)
          @name = @name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
          @package = package
        end

        def sources
          [code('java', 'java')]
        end
      end
    end
  end
end

module Jaspion
  module Kilza
    class Java
      class Property < Jaspion::Kilza::Property

        def class_name
          class_name = super
          class_name = class_name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(class_name.downcase).nil?
          class_name
        end

        def constants
          return '    private static final String FIELD_' +
          @name.upcase + ' = "' + @original_name + '";'
        end

        def declaration
          r = %(    @Expose
    @SerializedName(FIELD_#{@name.upcase})
)

          if array?
            r + "    private ArrayList<#{@type}> #{@name};"
          else
            r + "    private #{@type} #{@name};"
          end
        end

        def parse_element
          if object?
            "        this.#{@name} = new #{@type}(object.optJSONObject(FIELD_#{@name.upcase}));"
          elsif null?
            "        this.#{@name} = object.opt(FIELD_#{@name.upcase});"
          else
            "        this.#{@name} = object.opt#{@type}(FIELD_#{@name.upcase});"
          end
        end

        def parse_array
          r = %(        if (object.optJSONArray(FIELD_#{@name.upcase}) != null)
        {
            this.#{@name} = new ArrayList<>();
            JSONArray #{@name}JsonArray = object.optJSONArray(FIELD_#{@name.upcase});
            for (int i = 0; i < #{@name}JsonArray.length(); i++) {
          )

          if object? || null?
            r = r + "      JSONObject #{@name} = #{@name}JsonArray.optJSONObject(i);"
          else
            r = r + "      #{@type} #{@name} = #{@name}JsonArray.optJSON#{@type}(i);"
          end
          r = r + %(
                this.#{@name}.add(new #{@type}(#{@name}));
            }
        })
          return r
        end

        def parse_json
          if array?
            parse_array
          else
            parse_element
          end
        end

        def setter
          newname = @name.gsub(/_*(.+)/) { $1 }.capitalize
          r = StringIO.new
          if array?
            r << "public void set#{newname}(ArrayList<#{@type}> value) {"
          else
            r << "public void set#{newname}(#{@type} value) {"
          end
          r << "\n        this.#{@name} = value;\n    }"
          r.string
        end

        def getter
          newname = @name.gsub(/_*(.+)/) { $1 }.capitalize
          r = StringIO.new
          if array?
            r << "public ArrayList<#{@type}> get#{@name.capitalize}() {"
          elsif boolean?
            r << "public #{@type} is#{newname}() {"
          else
            r << "public #{@type} get#{newname}() {"
          end
          r << "\n        return this.#{@name};\n    }"
          r.string
        end
      end
    end
  end
end

module Jaspion
  module Kilza
    # Objective-C Language parser
    class Java
      include Jaspion::Kilza::Language

      RESERVED_PROPERTY_PREFIX = '_'
      RESERVED_CLASS_POSFIX = 'Class'
      RESERVED_WORDS = %w(
        abstract continue for new switch assert default goto,
        package synchronized boolean do if private this break double implements,
        protected throw byte else import public throws case enum instanceof,
        null return transient catch extends int short try char final interface static,
        void class finally long strictfp volatile const float native super while
      )

      def initialize(json_string)
        super(json_string)

        @types = {
          'nilclass' => 'Object',
          'string' => 'String',
          'fixnum' => 'Long',
          'float' => 'Double',
          'falseclass' => 'Boolean',
          'trueclass' => 'Boolean',
          'hash' => 'Object'
        }

        @equal_keys = %w(id identifier uid)
      end

      def clazz(name)
        Jaspion::Kilza::Java::Class.new(name)
      end

      def property(name, type, array, key)
        original_name = name
        name = RESERVED_PROPERTY_PREFIX + name unless RESERVED_WORDS.index(name).nil?
        prop = Jaspion::Kilza::Java::Property.new(name , type, array, key)
        prop.original_name = original_name
        prop
      end

      def classes(class_name)
        super(class_name)

        @classes.each do |cl|
          cl.properties.each do |pr|
            pr.type = pr.class_name if pr.object? || (pr.array? && pr.null?)

            cl.imports.push('import java.util.ArrayList;') if pr.array? &&
              cl.imports.index('import java.util.ArrayList;').nil?

            pr.type = @types[pr.type] unless @types[pr.type].nil?
          end
        end
      end
    end
  end
end
