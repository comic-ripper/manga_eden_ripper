require 'spec_helper'

describe BatotoRipper::TitleParser do
  subject(:parser) { BatotoRipper::TitleParser.new(title) }
  let(:title) { "Ch. 1: A Simple Title." }

  describe "#chapter" do
    context "The text is simple" do
      it "parses the link text for the parser chapter" do
        expect(parser.chapter).to eql "1"
      end
    end

    context "The text is different" do
      let(:title) { "Ch. 3: Reveng of the test" }
      it "will still parse the value" do
        expect(parser.chapter).to eql "3"
      end
    end

    context "The parser has a version 2" do
      let(:title) { "Ch. 1236v2: Reveng of the test" }
      it "will still parse the value" do
        expect(parser.chapter).to eql "1236"
      end
    end

    context "Half parsers" do
      let(:title) { "Ch. 12.4: foo-a" }
      it "will still parse the value" do
        expect(parser.chapter).to eql "12.4"
      end
    end

    context "There is a n-a and n-b in the parser" do
      let(:title) { "Ch. 12-a: 3.1415926535898" }
      it "will still parse the value" do
        expect(parser.chapter).to eql "12-a"
      end
    end

    context "There is a volume in the title" do
      let(:title) { "Vol.16 Ch.97: Level 97" }
      it "will parse out the correct chapter" do
        expect(parser.chapter).to eql "97"
      end
    end
  end

  describe("#volume") do
    context "There is no volume" do
      it "will be nil" do
        expect(parser.volume).to eql nil
      end
    end

    context "volume is present" do
      let(:title) { "Vol.16 Ch.97: Level 97" }
      it "will parse the volume correctly" do
        expect(parser.volume).to eql 16
      end
    end
  end

  describe "#name" do
    it "strips preceeding whitespace" do
      expect(parser.name).to eql "A Simple Title."
    end

    context "There is trailing whitespace" do
      let(:title) { "Ch.1 : There is a lot of whitespace!     " }
      it "strips tailing whitespace" do
        expect(parser.name).to eql "There is a lot of whitespace!"
      end
    end
  end
end
