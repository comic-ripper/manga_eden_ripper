module BatotoRipper
  class Chapter
    attr_reader :url, :text

    def initialize(url:, text:, **_extra)
      @url = url
      @text = text
    end

    def pages
      page_items.map do |page|
        Page.new url: page["value"], number: page.text.match(/(\d+)/)[0].to_f
      end
    end

    def number
      title_parser.chapter
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        url: url,
        text: text
      }.to_json(*a)
    end

    def self.json_create(data)
      new(url: data['url'], text: data['text'])
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
