require 'spec_helper'

describe BatotoRipper::Page, vcr: true do
  subject(:page) { BatotoRipper::Page.new url: url, number: number}
  let(:url) { "http://www.batoto.net/read/_/88615/100-is-too-cheap_by_peebs/1" }
  let(:number) { 1.0 }

  let(:example_image_url) { "http://img.batoto.net/comics/2012/03/07/1/read4f56f30a7a3b9/img000001.png" }

  describe "#image_url" do
    it "gets the image url" do
      expect(page.image_url).to eql example_image_url
    end

    it "caches the image url / page" do
      page.image_url
      page.image_url
      expect(a_request(:get, url)).to have_been_made.once # and only once
    end
  end


  describe "JSON Serialization / Unserialization" do
    it "will serialize and deserialize into itself" do
      expect(JSON.load(page.to_json).url).to eql url
      expect(JSON.load(page.to_json).number).to eql number

      expect(a_request(:get, url)).to_not have_been_made.once
    end

    context "The image_url has been retrieved" do
      subject(:page) do
         BatotoRipper::Page.new url: url, number: number, image_url:image_url
      end

      let(:image_url) { "Not a real image" }

      it "caches and saves image url" do
        expect(JSON.load(page.to_json).image_url).to eql image_url
        expect(a_request(:get, url)).to_not have_been_made
      end
    end
  end

end
