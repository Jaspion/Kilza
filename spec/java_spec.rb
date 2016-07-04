require 'coveralls'
Coveralls.wear!

require 'spec_helper'
require 'fileutils'
require 'erubis'
require 'jaspion/kilza'

describe Jaspion::Kilza do
  let(:res_path) { File.join(File.dirname(__FILE__), '..', 'spec', 'res') }
  let(:res_java) { File.join(res_path, 'java') }

  let(:json_path) { File.join(res_path, 'test.json') }
  let(:json_string) { File.read(json_path) }
  let(:json_array) { File.read(File.join(res_path, 'array.json')) }

  let(:json_reservedwords) { File.read(File.join(res_path, 'reservedwords.json')) }
  context 'when json has reserved words' do
    subject(:java) { Jaspion::Kilza::Java.new(json_reservedwords) }

    describe '#classes' do
      it { expect(java.classes('ReservedWords').size).to eq(2) }

      it 'compares the source codes' do
        java.classes('ReservedWords').each do |c|
          c.parcelable = true

          c.sources.each do |s|
            res_spec = File.join(res_java, 'reservedwords', s.file_name)
            test_source = File.read(res_spec)
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
          end
        end
      end
    end
  end

  let(:json_array) { File.read(File.join(res_path, 'array.json')) }
  context 'when json root element is not a hash' do
    subject(:java) { Jaspion::Kilza::Java.new(json_array) }

    describe '#classes' do
      it { expect(java.classes('BaseArray').size).to eq(1) }

      it 'compares the source codes' do
        java.classes('BaseArray').each do |c|
          c.parcelable = true

          c.sources.each do |s|
            test_source = File.read(File.join(res_java, 'array', s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_path, s.file_name), s.source)
          end
        end
      end
    end
  end

  let(:json_hash) { File.read(File.join(res_path, 'hash.json')) }
  context 'when json root element is a hash' do
    subject(:java) { Jaspion::Kilza::Java.new(json_hash) }

    describe '#classes' do
      it { expect(java.classes('Base').size).to eq(9) }

      it 'compares the source codes' do
        java.classes('Base').each do |c|
          c.parcelable = true

          c.sources.each do |s|
            test_source = File.read(File.join(res_java, 'hash', s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_java, 'hash', s.file_name), s.source)
          end
        end
      end
    end
  end
end
