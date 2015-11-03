require 'spec_helper'

describe MangaEdenRipper::Chapter, vcr: true, record: :once do
  subject(:chapter) do
    MangaEdenRipper::Chapter.new id: id, name: name, number: number
  end

  let(:name) { 'Weakness' }
  let(:id) { '56261ec8719a167d351d3d98' }
  let(:number) { 1 }

  describe '#pages' do
    it 'creates a Page' do
      expect(chapter.pages.first).to be_a MangaEdenRipper::Page
    end

    it 'has the correct number of pages' do
      expect(chapter.pages.count).to eql 13
    end

    it 'has unique page numbers' do
      numbers = chapter.pages.map(&:number)
      expect(numbers).to eql numbers.uniq
    end
  end

  describe '#number' do
    it 'uses the right number' do
      expect(chapter.number).to eql 1
    end
  end

  describe '#volume' do
    context 'there is no volume' do
      it 'is nil' do
        expect(chapter.volume).to eql nil
      end
    end
  end

  describe '#title' do
    it 'gets the title' do
      expect(chapter.title).to eql 'Weakness'
    end
  end

  describe 'JSON Serialization / Unserialization' do
    it 'will serialize and deserialize into itself' do
      expect(JSON.load(chapter.to_json).name).to eql name
      expect(JSON.load(chapter.to_json).id).to eql id
      expect(JSON.load(chapter.to_json).number).to eql number
    end
  end
end
