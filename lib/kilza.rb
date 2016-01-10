require "kilza/version"

require 'kilza/source'
require 'kilza/class'
require 'kilza/property'
require 'kilza/language'
require 'kilza/language/objc'
require 'kilza/language/java'

class String
  # Test if the string can be a number
  #
  # @param str [String] string to be tested
  # @return [Boolean] true in case of success
  def is_number?
    true if Float(self) rescue false
  end
end

module Kilza
  # Removes everything except numbers and letters.
  #
  # @param str [String] string to be cleaned
  # @return [String] cleaned string
  def self.clean(str)
    if str[0].is_number?
      str = '_' + str
    end
    str.gsub(/[^a-zA-Z0-9]/, '_')
  end

  # Cleans the string and make it lowercase.
  #
  # @param str [String] string to be cleaned
  # @return [String] cleaned string
  def self.normalize(str)
    Kilza::clean(str).downcase
  end
end
