require 'thread'
module MangaEdenRipper
  class Directory
    DIRECTORY_URL = 'https://www.mangaeden.com/api/list/0/'

    def initialize(db:nil, alias_index:nil)
      @db = db
      @alias_index = alias_index
      @index_mutex = Mutex.new
      @db_mutex = Mutex.new
    end

    def to_json(*args)
      {
        JSON.create_id => self.class,
        db: @db,
        alias_index: @alias_index
      }.to_json(*args)
    end

    def self.json_create(data)
      new(
        db: data['db'],
        alias_index: data['alias_index']
      )
    end

    def find_by_alias(m_alias)
      alias_index[m_alias]
    end

    private

    def alias_index
      return @alias_index if @alias_index
      @index_mutex.synchronize do
        @alias_index = {}
        db['manga'].each do |entry|
          @alias_index[entry['a']] = entry
        end
        @alias_index
      end
    end

    def db
      return @db if @db
      @db_mutex.synchronize do
        @db = JSON.parse MangaEdenRipper.session.get(DIRECTORY_URL).body
      end
    end
  end

  def self.directory
    @directory ||= Directory.new
  end
end
