require 'spec_helper'

describe BatotoRipper::Comic do
  subject(:parser) { BatotoRipper::Comic.new comic_url }
  let(:comic_url) { "http://www.batoto.net/comic/_/comics/100-is-too-cheap-r3893" }

  around(:each) do |test|
    VCR.use_cassette('comic', &test)
  end

  describe "#get" do
    it "gets the url" do
      expect(parser.get)
    end
  end
end
