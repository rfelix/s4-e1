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

    def list_by_season(show, season)
      show_id = @tv_db.show_id_for(show)
      info = @tv_db.show_seasons_info_for(show_id, season)

      results = []
      info['Data']['Episode'].each do |episode|
        next unless episode['SeasonNumber'] == season.to_s
        results << { :number => episode['EpisodeNumber'], :name => episode['EpisodeName']}
      end
      results
    end

    def episode_by_title(show, title, season = nil)
      show_id = @tv_db.show_id_for(show)
      info = @tv_db.show_seasons_info_for(show_id, season)

      results = []
      info['Data']['Episode'].each do |episode|
        next if season != nil && episode['SeasonNumber'] != season.to_s
        next unless episode['EpisodeName'] =~ /#{title}/i
        results << {
          :number => episode['EpisodeNumber'],
          :name => episode['EpisodeName'],
          :season => episode['EpisodeSeason']
        }
      end
      results
    end

  end
end
