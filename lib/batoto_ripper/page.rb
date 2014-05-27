module BatotoRipper
  class Page
    attr_accessor :url, :number, :image_url
    def initialize url:, number:, image_url:nil, **_args
      @url = url
      @number = number
      @image_url = image_url
    end

    def image_url
      @image_url ||= document.css("img#comic_page").first["src"]
    end

    def image
      @image ||= RestClient.get image_url
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        url: @url,
        number: @number,
        image_url: @image_url
      }.to_json(*a)
    end

    def self.json_create(data)
      new(url: data['url'], number: data['number'], image_url: data['image_url'])
    end

    private

    def page
      @page ||= RestClient.get url
    end

    def document
      @document ||= Nokogiri::HTML(page)
    end
  end
end
