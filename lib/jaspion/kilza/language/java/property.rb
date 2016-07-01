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
