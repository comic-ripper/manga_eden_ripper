# frozen_string_literal: true
module MangaEdenRipper
  class Chapter
    CHAPTER_URL = 'https://www.mangaeden.com/api/chapter/:id/'.freeze

    attr_accessor :number, :name, :id

    def initialize(number:, name:, id:, **_extra)
      @number = number
      @name = name
      @id = id
    end

    def pages
      page_data['images'].map do |page_number, image_path, _size_x, _size_y|
        Page.new number: page_number, image_path: image_path
      end
    end

    def volume
      nil
    end

    def title
      name
    end

    def to_json(*a)
      {
        JSON.create_id => self.class.name,
        number: number,
        name: name,
        id: id
      }.to_json(*a)
    end

    def self.json_create(data)
      new(
        number: data['number'],
        name: data['name'],
        id: data['id']
      )
    end

    private

    def page_data
      @page_data ||= JSON.parse(
        MangaEdenRipper.session.get(
          CHAPTER_URL.gsub(':id', id)
        ).body
      )
    end
  end
end
