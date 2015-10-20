require 'rest-client'
require 'nokogiri'
require 'pry'

module BatotoRipper
  class Comic
    attr_accessor :url, :language

    def initialize(url:, language: 'lang_English', **_extra)
      @url = url
      @language = language
    end

    def chapters
      chapter_rows.map do |row|
        link = row.css('td a')[0]
        Chapter.new(
          text: link.text.strip,
          url: link['href'].strip,
          translator: row.css('td')[2].text.strip
        )
      end
    end

    def to_json(*options)
      as_json.to_json(*options)
    end

    def as_json(*_options)
      {
        JSON.create_id => self.class.name,
        url: url,
        language: language
      }
    end

    def self.json_create(data)
      new(url: data['url'], language: data['language'])
    end

    private

    def page
      @page ||= RestClient.get url
    end

    def document
      @document ||= Nokogiri::HTML(page)
    end

    def chapter_rows
      document.css(".#{language}")
    end
  end
end
