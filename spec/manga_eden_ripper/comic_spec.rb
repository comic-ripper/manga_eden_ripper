require 'spec_helper'

describe MangaEdenRipper::Comic, vcr: true, record: :once do
  subject(:comic) { MangaEdenRipper::Comic.new url: url }
  let(:url) do
    'https://www.mangaeden.com/en/en-manga/hajime-no-ippo/'
  end

  describe '.applies?' do
    it 'accepts valid urls' do
      expect(MangaEdenRipper::Comic.applies?(url)).to be true
    end
    it 'rejects invalid urls' do
      expect(MangaEdenRipper::Comic.applies?('http://google.com')).to be false
      expect(MangaEdenRipper::Comic.applies?('batoto')).to be false
    end
  end

  describe '#chapters' do
    it 'creates a Chapter' do
      expect(comic.chapters.first).to be_a MangaEdenRipper::Chapter
    end

    context 'There are chapters' do
      it 'gets an array of chapters' do
        expect(comic.chapters.count).to eql 1118
      end
    end

    let(:first_chapter_id) do
      '56261ec8719a167d351d3d98'
    end

    it 'gives chapters with the correct information' do
      expect(comic.chapters[0].title).to eql 'Weakness'
      expect(comic.chapters[0].id).to eql first_chapter_id
    end
  end

  describe 'JSON Serialization / Unserialization' do
    it 'will serialize and deserialize into itself' do
      expect(JSON.load(comic.to_json).url).to eql url
    end
  end
end
