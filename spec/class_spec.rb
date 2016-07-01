require 'coveralls'
Coveralls.wear!

require 'spec_helper'
require 'fileutils'
require 'jaspion/kilza'

describe Jaspion::Kilza::Class do
  let(:clazz) { Class.new { include Jaspion::Kilza::Class } }
  let(:object) { clazz.new('name') }

  describe '#new' do
    it { expect(object).not_to be_nil }
  end

  describe '#push_import' do
    it do
      object.push_import('string')
      expect(object.imports).to eq(['string'])
    end
  end

  describe '#imports' do
    it do
      object.push_import('1')
      object.push_import(['2'])
      object.push_import('3')
      expect(object.imports).to eq(['1', '', '2', '', '3'])
    end
  end

  describe '#delete_import' do
    it do
      object.push_import('1')
      object.push_import(['2'])
      object.push_import('3')
      object.delete_import(['2'])
      expect(object.imports).to eq(['1', '', '3'])
    end
  end

  describe '#push' do
    let(:property) { Jaspion::Kilza::Property.new('', '', false, '') }

    it do
      object.push(property)

      property.name = 'name'
      property.type = 'type'
      property.array = true
      property.key = 'key'
      object.push(property)

      expect(object.properties.length).to eq(1)
      expect(object.properties.first.name).to eq('name')
      expect(object.properties.first.type).to eq('type')
      expect(object.properties.first.array).to eq(true)
      expect(object.properties.first.key).to eq('key')
    end
  end
end
