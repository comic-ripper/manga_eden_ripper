require 'spec_helper'

describe BatotoRipper::Comic, vcr: true, record: :once do
  subject(:comic) { BatotoRipper::Comic.new url: url }
  let(:url) do
    'https://bato.to/comic/_/comics/100-is-too-cheap-r3893'
  end

  describe '.applies?' do
    it 'accepts valid urls' do
      expect(BatotoRipper::Comic.applies?(url)).to be true
    end
    it 'rejects invalid urls' do
      expect(BatotoRipper::Comic.applies?('http://google.com')).to be false
      expect(BatotoRipper::Comic.applies?('batoto')).to be false
    end
  end

  describe '#chapters' do
    it 'creates a Chapter' do
      expect(comic.chapters.first).to be_a BatotoRipper::Chapter
    end

    context 'There is a single chapter' do
      it 'gets an array of chapters' do
        expect(comic.chapters.count).to eql 1
      end
    end

    context 'There are many chapters' do
      let(:url) { 'http://bato.to/comic/_/medaka-box-r49' }
      it 'gets many chapters' do
        expect(comic.chapters.count).to eql 206
      end
    end

    let(:first_chapter_url) do
      'http://bato.to/reader#4aba6fc934a8d6c2'
    end

    it 'gives chapters with the correct information' do
      expect(comic.chapters[0].text).to eql 'Ch.0: [Oneshot]'
      expect(comic.chapters[0].url).to eql first_chapter_url
    end
  end

  describe 'JSON Serialization / Unserialization' do
    it 'will serialize and deserialize into itself' do
      expect(JSON.load(comic.to_json).url).to eql url
    end
  end
end
