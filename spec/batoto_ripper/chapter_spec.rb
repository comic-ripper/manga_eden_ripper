require 'spec_helper'

describe BatotoRipper::Chapter, vcr: true, record: :once do
  subject(:chapter) { BatotoRipper::Chapter.new url: url, text: link_text }
  let(:link_text) { 'Ch.0: [Oneshot]' }
  let(:url) { 'http://bato.to/reader#4aba6fc934a8d6c2' }

  describe '#pages' do
    it 'creates a Page' do
      expect(chapter.pages.first).to be_a BatotoRipper::Page
    end

    it 'has the correct number of pages' do
      expect(chapter.pages.count).to eql 31
    end

    it 'has unique page numbers' do
      numbers = chapter.pages.map(&:number)
      expect(numbers).to eql numbers.uniq
    end
  end

  describe '#number' do
    it 'uses the right number' do
      expect(chapter.number).to eql '0'
    end
  end

  describe '#volume' do
    context 'there is no volume' do
      it 'is nil' do
        expect(chapter.volume).to eql nil
      end
    end

    context 'there is a volume' do
      let(:link_text) { 'Vol.3 Ch.12: Revenge of the volume.' }
      it 'is a number' do
        expect(chapter.volume).to eql 3
      end
    end
  end

  describe '#title' do
    it 'gets the title' do
      expect(chapter.title).to eql '[Oneshot]'
    end
  end

  describe 'JSON Serialization / Unserialization' do
    it 'will serialize and deserialize into itself' do
      expect(JSON.load(chapter.to_json).url).to eql url
      expect(JSON.load(chapter.to_json).text).to eql link_text
    end
  end
end
