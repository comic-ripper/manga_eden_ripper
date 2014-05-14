require 'spec_helper'

describe BatotoRipper::Comic, vcr: true do
  subject(:parser) { BatotoRipper::Comic.new url: url }
  let(:url) { "http://www.batoto.net/comic/_/comics/100-is-too-cheap-r3893" }

  describe "#chapters" do
    context "There is a single chapter" do
      it "gets an array of chapters" do
        expect(parser.chapters.count).to eql 1
      end
    end

    context "There are many chapters" do
      let(:url) { "http://www.batoto.net/comic/_/comics/beelzebub-r4" }
      it "gets many chapters" do
        expect(parser.chapters.count).to eql 250
      end
    end

    it "gives chapters with the correct information" do
      expect(parser.chapters[0]).to eql(
        text: "Ch.0: [Oneshot]",
        url: "http://www.batoto.net/read/_/88615/100-is-too-cheap_by_peebs",
        date: Time.parse("07 March 2012 - 05:32 AM +00:00")
      )
    end
  end
end
