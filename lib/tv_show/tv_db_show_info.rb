module TvShow
  class TvDbShowInfo

    def initialize(tv_db_api)
      @tv_db = tv_db_api
    end

    def name_by_episode(show, season, episode)
      show_id = @tv_db.show_id_for(show)
      info = @tv_db.show_info_for(show_id, season, episode)
      info['Data']['Episode']['EpisodeName']
    end

  end
end
