require 'coveralls'
Coveralls.wear!

require 'spec_helper'
require 'fileutils'
require 'erubis'
require 'jaspion/kilza'

describe Jaspion::Kilza do
  let(:res_path) { File.join(File.dirname(__FILE__), '..', 'spec', 'res') }
  let(:json_path) { File.join(res_path, 'test.json') }
  let(:json_string) { File.read(json_path) }
  let(:json_array) { File.read(File.join(res_path, 'array.json')) }

  context 'when json root element is an hash' do
    subject(:objc) { Jaspion::Kilza::Objc.new(json_string) }

    describe '#classes' do
      it { expect(objc.classes('Base').size).to eq(8) }

      it 'compares the source codes' do
        objc.classes('Base').each do |c|
          c.sources.each do |s|
            res_spec = File.join(res_path, s.file_name)
            test_source = File.read(res_spec)
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
          end
        end
      end
    end
  end

  context 'when json root element is an array' do
    subject(:objc) { Jaspion::Kilza::Objc.new(json_array) }

    describe '#classes' do
      it { expect(objc.classes('BaseArray').size).to eq(1) }

      it 'compares the source codes' do
        objc.classes('BaseArray').each do |c|
          c.sources.each do |s|
            test_source = File.read(File.join(res_path, s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_path, s.file_name), s.source)
          end
        end
      end
    end
  end

  # describe 'test java' do
  #   it 'Hash JSON - lists all classes' do
  #     @java = Jaspion::Kilza::Java.new(@json_string)
  #     @java.classes('Base').each do |c|
  #       c.sources.each do |s|
  #         test_source = File.read(File.join(@res_path, s.file_name))
  #         eruby = Erubis::Eruby.new(test_source)
  #         expect(s.source).to eq(eruby.result)
  #       end
  #     end
  #   end
  #
  #   it 'Array JSON - lists all classes' do
  #     @java = Jaspion::Kilza::Java.new(@json_array)
  #     @java.classes('BaseArray').each do |c|
  #       c.sources.each do |s|
  #         test_source = File.read(File.join(@res_path, s.file_name))
  #         eruby = Erubis::Eruby.new(test_source)
  #         expect(s.source).to eq(eruby.result)
  #
  #         # File.write(File.join(@res_path, s.file_name), s.source)
  #       end
  #     end
  #   end
  # end
end
