require "kilza/version"

require 'kilza/source'
require 'kilza/class'
require 'kilza/property'
require 'kilza/language'
require 'kilza/language/objc'
require 'kilza/language/java'

class String
  def is_number?
    true if Float(self) rescue false
  end
end

module Kilza
  def self.clean(str)
    if str[0].is_number?
      str = '_' + str
    end
    str = str.gsub(/[^a-zA-Z0-9]/, '_')
  end

  def self.normalize(str)
    str = Kilza::clean(str).downcase
  end
end
