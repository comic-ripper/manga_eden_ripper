require 'manga_eden_ripper/version'
require 'manga_eden_ripper/session'
require 'manga_eden_ripper/comic'
require 'manga_eden_ripper/chapter'
require 'manga_eden_ripper/title_parser'
require 'manga_eden_ripper/page'

module MangaEdenRipper
  def self.parsers
    [
      MangaEdenRipper::Comic
    ]
  end
end
