require 'coveralls'
Coveralls.wear!

require 'spec_helper'
require 'fileutils'
require 'erubis'
require 'jaspion/kilza'

describe Jaspion::Kilza do
  let(:res_path) { File.join(File.dirname(__FILE__), '..', 'spec', 'res') }
  let(:res_swift) { File.join(res_path, 'swift') }
  let(:json_path) { File.join(res_path, 'test.json') }
  let(:json_string) { File.read(json_path) }
  let(:json_array) { File.read(File.join(res_path, 'array.json')) }

  let(:json_reservedwords) { File.read(File.join(res_path, 'reservedwords.json')) }
  context 'when json has reserved words' do
    subject(:objc) { Jaspion::Kilza::Swift.new(json_reservedwords) }

    describe '#classes' do
      it { expect(objc.classes('ReservedWords').size).to eq(2) }

      it 'compares the source codes' do
        objc.classes('ReservedWords').each do |c|
          c.sources.each do |s|
            res_spec = File.join(res_swift, 'reservedwords', s.file_name)
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
    subject(:swift) { Jaspion::Kilza::Swift.new(json_array) }

    describe '#classes' do
      it { expect(swift.classes('BaseArray').size).to eq(1) }

      it 'compares the source codes' do
        swift.classes('BaseArray').each do |c|
          c.sources.each do |s|
            test_source = File.read(File.join(res_swift, 'array', s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_path, s.file_name), s.source)
          end
        end
      end
    end
  end

  let(:json_hash) { File.read(File.join(res_path, 'hash.json')) }
  context 'when json root element is not a hash' do
    subject(:swift) { Jaspion::Kilza::Swift.new(json_hash) }

    describe '#classes' do
      it { expect(swift.classes('Base').size).to eq(8) }

      it 'compares the source codes' do
        swift.classes('Base').each do |c|
          c.sources.each do |s|
            test_source = File.read(File.join(res_swift, 'hash', s.file_name))
            eruby = Erubis::Eruby.new(test_source)

            expect(s.source).to eq(eruby.result)
            # File.write(File.join(res_swift, 'hash', s.file_name), s.source)
          end
        end
      end
    end
  end
end
