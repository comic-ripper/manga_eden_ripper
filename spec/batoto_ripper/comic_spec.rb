require 'spec_helper'

describe BatotoRipper::Comic, vcr: true do
  subject(:comic) { BatotoRipper::Comic.new url: url }
  let(:url) do
    'http://www.batoto.net/comic/_/comics/100-is-too-cheap-r3893'
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
      let(:url) { 'http://www.batoto.net/comic/_/comics/beelzebub-r4' }
      it 'gets many chapters' do
        expect(comic.chapters.count).to eql 250
      end
    end

    let(:first_chapter_url) do
      'http://www.batoto.net/read/_/88615/100-is-too-cheap_by_peebs'
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
