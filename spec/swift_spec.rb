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

  describe 'test swift' do
    it 'Hash JSON - lists all classes' do
      @swift = Jaspion::Kilza::Swift.new(json_string)
      @swift.classes('Base').each do |c|
        c.sources.each do |s|
          test_source = File.read(File.join(res_path, s.file_name))
          eruby = Erubis::Eruby.new(test_source)
          expect(s.source).to eq(eruby.result)
          # f_path = File.expand_path(File.join(res_path, s.file_name))
          # File.write(f_path, s.source)

        end
      end
    end

    it 'Array JSON - lists all classes' do
      @swift = Jaspion::Kilza::Swift.new(json_array)
      @swift.classes('BaseArray').each do |c|
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
