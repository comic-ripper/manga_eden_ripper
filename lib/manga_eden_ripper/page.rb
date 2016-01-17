# frozen_string_literal: true
module MangaEdenRipper
  class Page
    IMAGE_BASE = 'https://cdn.mangaeden.com/mangasimg/'.freeze

    attr_accessor :number, :image_path
    def initialize(number:, image_path:, **_args)
      @number = number
      @image_path = image_path
    end

    def image_url
      IMAGE_BASE + image_path
    end

    def image
      @image ||= MangaEdenRipper.session.get image_url
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        number: @number,
        image_path: @image_path
      }.to_json(*a)
    end

    def self.json_create(data)
      new(
        number: data['number'],
        image_path: data['image_path']
      )
    end
  end
end
