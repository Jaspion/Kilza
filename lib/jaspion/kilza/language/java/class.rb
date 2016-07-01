module Jaspion
  module Kilza
    class Java
      class Class
        include Jaspion::Kilza::Class

        # Represents the Java class package
        attr_accessor :package

        attr_reader :gson
        attr_reader :serializable
        attr_reader :parcelable

        alias :gson? :gson
        alias_method :serializable?, :serializable
        alias_method :parcelable?, :parcelable

        def initialize(name, package = nil)
          super(name)
          @name = @name + RESERVED_CLASS_POSFIX unless RESERVED_WORDS.index(name.downcase).nil?
          @package = package
          push_import('import org.json.*;')

          self.serializable = true
          self.parcelable = false
          self.gson = true
        end

        def gson=(g)
          @gson = g

          if (g)
            i = %w(
              import\ com.google.gson.Gson;
              import\ com.google.gson.GsonBuilder;
              import\ com.google.gson.annotations.SerializedName;
              import\ com.google.gson.annotations.Expose;
            )

            push_import(i)
          else
            index = @imports.index(i)
            unless index.nil?
              (0..5).each { @imports.delete_at(index - 1) }
            end
          end
        end

        def parcelable=(p)
          @parcelable = p
          if (p)
            push_import('import android.os.Parcelable;')
          else
            index = @imports.index('import android.os.Parcelable;')
            unless index.nil?
              (0..2).each { @imports.delete_at(index - 1) }
            end
          end
        end

        def serializable=(s)
          @serializable = s
          if (s)
            push_import('import java.io.Serializable;')
          else
            index = @imports.index('import java.io.Serializable;')
            unless index.nil?
              (0..2).each { @imports.delete_at(index - 1) }
            end
          end
        end

        def sources
          [code('java', 'java')]
        end
      end
    end
  end
end
