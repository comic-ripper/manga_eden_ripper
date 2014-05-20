module BatotoRipper
  class Chapter
    attr_reader :url, :text, :translator

    def initialize(url:, text:, translator:nil, **_extra)
      @url = url
      @text = text
      @translator = translator
    end

    def pages
      page_items.map do |page|
        Page.new url: page["value"], number: page.text.match(/(\d+)/)[0].to_f
      end
    end

    def number
      title_parser.chapter
    end

    def volume
      title_parser.volume
    end

    def title
      title_parser.name
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        url: url,
        text: text,
        translator: translator
      }.to_json(*a)
    end

    def self.json_create(data)
      new(url: data['url'], text: data['text'], translator: data['translator'])
    end

    private

    def page
      @page ||= RestClient.get url
    end

    def document
      @document ||= Nokogiri::HTML(page)
    end

    def page_items
      document.css("#page_select").first.css("option")
    end

    def title_parser
      BatotoRipper::TitleParser.new(text)
    end
  end
end
