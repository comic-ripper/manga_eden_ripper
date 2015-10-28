module BatotoRipper
  class Chapter
    attr_accessor :url, :text, :translator

    def initialize(url:, text:, translator:nil, **_extra)
      @url = url
      @text = text
      @translator = translator
    end

    def pages
      page_items.map do |page|
        Page.new url: page['value']
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

    def id
      URI.parse(url).fragment.split('_')[0]
    end

    private

    def page
      @page ||= BatotoRipper.session.get "https://bato.to/areader?id=#{id}&p=1", [], url
    end

    def document
      @document ||= Nokogiri::HTML(page.content)
    end

    def page_items
      document.css('#page_select').first.css('option')
    end

    def title_parser
      BatotoRipper::TitleParser.new(text)
    end
  end
end
