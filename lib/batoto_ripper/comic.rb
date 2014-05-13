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
      chapter_rows.map do |row|
        link = row.css("td a")[0]
        {
            text: link.text.strip,
            url: link["href"].strip,
            # batoto defaults to UTC when you aren't logged in.
            date: Time.parse(row.css("td")[4].text + " +00:00")
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

    def chapter_rows
      document.css(".#{language}")
    end
  end
end
