require "rest-client"
require "nokogiri"
require 'pry'

module BatotoRipper
  class Comic
    attr_reader :url, :language

    def initialize(url:, language: "lang_English", **_extra)
      @url = url
      @language = language
    end

    def chapters
      chapter_rows.map do |row|
        link = row.css("td a")[0]
        Chapter.new(
          text: link.text.strip,
          url: link["href"].strip,
          # batoto defaults to UTC when you aren't logged in.
          date: Time.parse(row.css("td")[4].text + " +00:00")
        )
      end
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        url: url,
        language: language
      }.to_json(*a)
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
