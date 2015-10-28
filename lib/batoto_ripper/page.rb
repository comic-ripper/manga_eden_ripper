module BatotoRipper
  class Page
    attr_accessor :url, :image_url
    def initialize(url:, image_url:nil, **_args)
      @url = url
      @image_url = image_url
    end

    def image_url
      @image_url ||= document.css('img#comic_page').first['src']
    end

    def image
      @image ||= BatotoRipper.session.get image_url
    end

    def chapter_id
      @chapter_id ||= URI.parse(url).fragment.split('_')[0]
    end

    def number
      @number ||= URI.parse(url).fragment.split('_')[1].to_f
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        url: @url,
        image_url: @image_url
      }.to_json(*a)
    end

    def self.json_create(data)
      new(
        url: data['url'],
        image_url: data['image_url']
      )
    end

    private

    def page
      @page ||= BatotoRipper.session.get "https://bato.to/areader?id=#{chapter_id}&p=#{number.to_i}", [], url
    end

    def document
      @document ||= Nokogiri::HTML(page.content)
    end
  end
end
