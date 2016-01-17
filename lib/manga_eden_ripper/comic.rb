# frozen_string_literal: true
require 'nokogiri'
require 'uri'

module MangaEdenRipper
  class Comic
    VALID_HOSTS = [
      /mangaeden.com\z/
    ].freeze

    MANGA_INFO_URL = 'https://www.mangaeden.com/api/manga/:id'.freeze

    def self.applies?(url)
      uri = URI.parse(url)
      VALID_HOSTS.any? { |pattern| pattern.match uri.host }
    end

    attr_accessor :url, :language

    def initialize(url:, manga_eden_id:nil, **_extra)
      @url = url
      @manga_eden_id = manga_eden_id
    end

    def chapters
      info['chapters'].map do |number, _ts, name, id|
        Chapter.new(number: number, name: name, id: id)
      end
    end

    def to_json(*options)
      {
        JSON.create_id => self.class.name,
        url: url,
        manga_eden_id: @manga_eden_id
      }.to_json(*options)
    end

    def self.json_create(data)
      new(
        url: data['url'],
        manga_eden_id: data['manga_eden_id']
      )
    end

    # private
    def info
      @me_info ||= JSON.parse(
        MangaEdenRipper.session.get(
          MANGA_INFO_URL.gsub(':id', manga_eden_id)
        ).body
      )
    end

    def title_alias
      URI.parse(url).path.match(%r{/en/en-manga/([-\w]+)})[1]
    end

    def manga_eden_id
      MangaEdenRipper.directory.find_by_alias(title_alias)['i']
    end
  end
end
