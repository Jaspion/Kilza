require 'coveralls'
Coveralls.wear!

require 'spec_helper'
require 'fileutils'
require 'erubis'
require 'kilza'


describe 'Kilza' do
  before(:context) do
    @res_path = File.join(File.dirname(__FILE__), '..', 'spec', 'res')
    @json_path = File.join(@res_path, 'test.json')
    @json_string = File.read(@json_path)
  end

  describe 'test objc' do
    it 'lists all classes' do
      @objc = Kilza::Objc.new(@json_string)
      @objc.classes('Base').each do |c|
        c.sources.each do |s|
          res_spec = File.join(@res_path, s.file_name)
          test_source = File.read(res_spec)
          eruby = Erubis::Eruby.new(test_source)

          expect(s.source).to eq(eruby.result)
        end
      end
    end
  end

  describe 'test java' do
    it 'lists all classes' do
      @java = Kilza::Java.new(@json_string)
      @java.classes('Base').each do |c|
        c.sources.each do |s|
          test_source = File.read(File.join(@res_path, s.file_name))
          eruby = Erubis::Eruby.new(test_source)
          expect(s.source).to eq(eruby.result)
        end
      end
    end
  end
end
