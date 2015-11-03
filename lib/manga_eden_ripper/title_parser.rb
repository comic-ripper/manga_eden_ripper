module MangaEdenRipper
  class TitleNotMatchedError < StandardError
  end

  class TitleParser
    attr_reader :title

    def initialize(title_text)
      @title = title_text
    end

    # String chapter to be used with lexicographic sort
    def chapter
      matcher[2]
    end

    # Numeric volume
    def volume
      matcher[1].to_i if matcher[1]
    end

    def name
      matcher[3]
    end

    private

    def match_regex
      /
        ^(?:Vol\.\s*(\d+))?\s*       # Volume nr
        Ch.\s*([\d\.]+-?[a-uw-z\d]*) # Chapter nr
        (?:v\d+?)?\s*\:?\s*          # Version
        (.*[^\s])                    # Chapter name
      /x
    end

    def matcher
      match = match_regex.match(title)
      fail TitleNotMatchedError, title unless match
      match
    end
  end
end
