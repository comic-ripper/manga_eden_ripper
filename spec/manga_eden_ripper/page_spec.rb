require 'spec_helper'

describe MangaEdenRipper::Page, vcr: true do
  subject(:page) do
    MangaEdenRipper::Page.new image_path: image_path, number: number
  end

  let(:image_path) do
    '09/0931adc01475599dbdf42d92b80430aa22619192148ee9def6b66aad.png'
  end

  let(:number) { 12 }

  let(:example_image_url) do
    'https://cdn.mangaeden.com/mangasimg/09/0931adc01475599dbdf42d92b80430aa22619192148ee9def6b66aad.png'
  end

  describe '#image_url' do
    it 'gets the image url' do
      expect(page.image_url).to eql example_image_url
    end
  end

  describe 'JSON Serialization / Unserialization' do
    it 'will serialize and deserialize into itself' do
      expect(JSON.load(page.to_json).image_path).to eql image_path
      expect(JSON.load(page.to_json).number).to eql number

      expect(a_request(:get, image_path)).to_not have_been_made.once
    end
  end
end
