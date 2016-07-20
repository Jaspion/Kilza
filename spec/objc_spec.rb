require 'coveralls'
Coveralls.wear!

require 'spec_helper'
require 'fileutils'
require 'erubis'
require 'jaspion/kilza'

describe Jaspion::Kilza do
  let(:res_path) { File.join(File.dirname(__FILE__), '..', 'spec', 'res') }
  let(:res_objc) { File.join(res_path, 'objc') }
  let(:json_path) { File.join(res_path, 'test.json') }
  let(:json_string) { File.read(json_path) }
  let(:json_array) { File.read(File.join(res_path, 'array.json')) }

  let(:json_reservedwords) { File.read(File.join(res_path, 'reservedwords.json')) }
  context 'when json has reserved words' do
    subject(:objc) { Jaspion::Kilza::Objc.new(json_reservedwords) }

    describe '#classes' do
      it { expect(objc.classes('ReservedWords').size).to eq(2) }

      it 'compares the source codes' do
        objc.classes('ReservedWords').each do |c|
          c.sources.each do |s|
            res_spec = File.join(res_objc, 'reservedwords', s.file_name)
            test_source = File.read(res_spec)
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(res_spec, s.source)
          end
        end
      end
    end
  end

  let(:json_array) { File.read(File.join(res_path, 'array.json')) }
  context 'when json root element is not a hash' do
    subject(:objc) { Jaspion::Kilza::Objc.new(json_array) }

    describe '#classes' do
      it { expect(objc.classes('BaseArray').size).to eq(1) }

      it 'compares the source codes' do
        objc.classes('BaseArray').each do |c|
          c.sources.each do |s|
            test_source = File.read(File.join(res_objc, 'array', s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_objc, 'array', s.file_name), s.source)
          end
        end
      end
    end
  end

  let(:json_hash) { File.read(File.join(res_path, 'hash.json')) }
  context 'when json root element is a hash' do
    subject(:objc) { Jaspion::Kilza::Objc.new(json_hash) }

    describe '#classes' do
      it { expect(objc.classes('Base').size).to eq(9) }

      it 'compares the source codes' do
        objc.classes('Base').each do |c|
          c.sources.each do |s|
            test_source = File.read(File.join(res_objc, 'hash', s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_objc, 'hash', s.file_name), s.source)
          end
        end
      end
    end
  end

  context 'specifing the class without JSON' do
    let(:prop) { Jaspion::Kilza::Objc::Property.new('name', 'string', false) }
    let(:clazz) do
      cl = Jaspion::Kilza::Objc::Class.new('MyClass')
      cl.push(prop)
      cl
    end

    describe '#properties.size' do
      it { expect(clazz.properties.size).to eq(1) }
    end

    describe '#sources' do
      it do
        test_source = File.read(File.join(res_objc, 'MyClass.h'))
        eruby = Erubis::Eruby.new(test_source)
        expect(clazz.sources.first.source).to eq(eruby.result)
      end

      it do
        test_source = File.read(File.join(res_objc, 'MyClass.m'))
        eruby = Erubis::Eruby.new(test_source)
        expect(clazz.sources[1].source).to eq(eruby.result)
      end
    end
  end
end
