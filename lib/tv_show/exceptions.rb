module TvShow
  class TvShowException < Exception
    attr_reader :message
  end

  class ShowNameMissingException < TvShowException
    def initialize
      @message = "The TV Show name is missing"
    end
  end

  class WrongArgumentOrderException < TvShowException
    def initialize
      @message = "The Arguments used aren't in the right order"
    end
  end
end
