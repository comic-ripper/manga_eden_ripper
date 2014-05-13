require "rest-client"
require "nokogiri"
require 'pry'

module BatotoRipper
  class Comic
    attr_reader :index_url, :language

    def initialize(index_url, language = "lang_English")
      @index_url = index_url
      @language = language
    end

    def chapters
      document.css(".#{language}").map do |row|
        link = row.css("td a")[0]

        {
            text: link.text.strip,
            url: link["href"].strip
        }
      end
    end

    private
    def get_page
      @page ||= RestClient.get index_url
    end

    def document
      @document ||= Nokogiri::HTML(get_page)
    end
  end
end
