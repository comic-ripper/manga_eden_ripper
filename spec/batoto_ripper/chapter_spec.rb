require 'spec_helper'

describe BatotoRipper::Chapter, vcr: true do
  subject(:chapter) { BatotoRipper::Chapter.new url: url, text: link_text }
  let(:link_text) { "Ch.0: [Oneshot]" }
  let(:url) { "http://www.batoto.net/read/_/88615/100-is-too-cheap_by_peebs" }

  describe "#pages" do
    it "creates a Page" do
      expect(chapter.pages.first).to be_a BatotoRipper::Page
    end

    it "has the correct number of pages" do
      expect(chapter.pages.count).to eql 31
    end

    it "has unique page numbers" do
      numbers = chapter.pages.map &:number
      expect(numbers).to eql numbers.uniq
    end
  end

  describe "#number" do
    before do
      allow_any_instance_of(
        BatotoRipper::TitleParser
      ).to receive(:chapter).and_return(:chapter_number)
    end

    it "uses TitleParser" do
      expect(chapter.number).to eql :chapter_number
    end
  end

  describe "JSON Serialization / Unserialization" do
    it "will serialize and deserialize into itself" do
      expect(JSON.load(chapter.to_json).url).to eql url
      expect(JSON.load(chapter.to_json).text).to eql link_text
    end
  end
end
