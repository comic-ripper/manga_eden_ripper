require "rest-client"


module BatotoRipper
  # This class gets the index of the comic, and can give you a list of chapters for the comic
  class Comic

    # The URL of the comic index
    attr_reader :index_url

    # This class is intended to be somewhat immutable, but I might add metadata later
    def initialize(index_url)
      @index_url = index_url
    end

    # This part actually gets the page
    def get
      RestClient.get index_url
    end
  end
end
