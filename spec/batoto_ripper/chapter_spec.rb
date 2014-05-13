require 'spec_helper'

describe BatotoRipper::Chapter, vcr: true do
  subject(:chapter) { BatotoRipper::Chapter.new url, link_text }
  let(:link_text) {"Ch.0: [Oneshot]"}
  let(:url){ "http://www.batoto.net/read/_/88615/100-is-too-cheap_by_peebs" }

  describe "#pages" do
    it "has the correct number of pages" do
      expect(chapter.pages.count).to eql 31
    end

    it "has unique page numbers" do
      numbers = chapter.pages.map{|p| p[:number]}
      expect(numbers).to eql numbers.uniq
    end
  end

  describe "#number" do
    context "The text is simple" do
      it "parses the link text for the chapter number" do
        expect(chapter.number).to eql "0"
      end
    end

    context "The text is different" do
      let(:link_text) {"Ch. 3: Reveng of the test"}
      it "will still parse the value" do
        expect(chapter.number).to eql "3"
      end
    end

    context "The chapter has a version 2" do
      let(:link_text) {"Ch. 1236v2: Reveng of the test"}
      it "will still parse the value" do
        expect(chapter.number).to eql "1236"
      end
    end

    context "Half chapters" do
      let(:link_text) {"Ch. 12.4: foo-a"}
      it "will still parse the value" do
        expect(chapter.number).to eql "12.4"
      end
    end

    context "There is a n-a and n-b in the chapter" do
      let(:link_text) {"Ch. 12-a: 3.1415926535898"}
      it "will still parse the value" do
        expect(chapter.number).to eql "12-a"
      end
    end
  end
end
