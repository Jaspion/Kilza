require 'jaspion/kilza/version'

require 'jaspion/kilza/source'
require 'jaspion/kilza/class'
require 'jaspion/kilza/property'
require 'jaspion/kilza/language'
require 'jaspion/kilza/language/objc'
require 'jaspion/kilza/language/objc/class'
require 'jaspion/kilza/language/objc/property'
require 'jaspion/kilza/language/java'
require 'jaspion/kilza/language/java/class'
require 'jaspion/kilza/language/java/property'
require 'jaspion/kilza/language/swift'
require 'jaspion/kilza/language/swift/class'
require 'jaspion/kilza/language/swift/property'

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

# Ruby class
class Array
  # Inserts an separator between each element
  #
  # @param sep [String] string to be used as separator
  #
  # @return [Array] the new array
  def separate(sep = '')
    a = self
    l = a.length - 2
    (0..l).each { |i| a.insert(((2 * i) + 1), sep) }
    a
  end

  # Inserts an separator between each element
  #
  # @param sep [String] string to be used as separator
  def separate!(sep = '')
    l = length - 2
    (0..l).each { |i| insert(((2 * i) + 1), sep) }
  end
end

# Tranforms a JSON string into Objects
module Jaspion
  module Kilza

  end
end
