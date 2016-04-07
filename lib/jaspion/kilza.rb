require 'jaspion/kilza/version'

require 'jaspion/kilza/source'
require 'jaspion/kilza/class'
require 'jaspion/kilza/property'
require 'jaspion/kilza/language'
require 'jaspion/kilza/language/objc'
require 'jaspion/kilza/language/java'

# Ruby class
class String
  # Test if the string can be a number
  #
  # @param str [String] string to be tested
  #
  # @return [Boolean] true in case of success
  def number?
    true if Float(self) rescue false
  end
end

# Tranforms a JSON string into Objects
module Jaspion
  module Kilza
    # Removes everything except numbers and letters.
    #
    # @param str [String] string to be cleaned
    #
    # @return [String] cleaned string
    def self.clean(str)
      return if str.nil?
      str = '_' + str if str[0].number?
      str.gsub(/[^a-zA-Z0-9]/, '_')
    end

    # Cleans the string and make it lowercase.
    #
    # @param str [String] string to be cleaned
    #
    # @return [String] cleaned string
    def self.normalize(str)
      return if str.nil?
      Jaspion::Kilza.clean(str).downcase
    end
  end
end
