require 'batoto_ripper/version'
require 'batoto_ripper/comic'
require 'batoto_ripper/chapter'
require 'batoto_ripper/title_parser'
require 'batoto_ripper/page'

module BatotoRipper
  def self.parsers
    [
      BatotoRipper::Comic
    ]
  end
end
