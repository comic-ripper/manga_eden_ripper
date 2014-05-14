module BatotoRipper
  class Chapter
    attr_reader :index_url, :link_text

    def initialize(url, link_text)
      @index_url = url
      @link_text = link_text
    end

    def pages
      page_items.map do |page|
        {url: page["value"], number: page.text.match(/(\d+)/)[0].to_f}
      end
    end

    def number
      title_parser.chapter
    end

    private

    def page
      @page ||= RestClient.get index_url
    end

    def document
      @document ||= Nokogiri::HTML(page)
    end

    def page_items
      document.css("#page_select").first.css("option")
    end

    def title_parser
      BatotoRipper::TitleParser.new(link_text)
    end
  end
end
