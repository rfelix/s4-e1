module TvShow
  module TvDb
    class ShowInfo

      def initialize(show, tv_db_api)
        @show  = show
        @tv_db = tv_db_api
      end

      def name_by_episode(season, episode)
        show_id = @tv_db.show_id(@show)
        info = @tv_db.show_info(:id => show_id, :season => season, :episode => episode)
        info['Data']['Episode']['EpisodeName']
      end

      def list_by_season(season)
        show_id = @tv_db.show_id(@show)
        info = @tv_db.season_info(show_id, season)

        results = []
        info['Data']['Episode'].each do |episode|
          next unless episode['SeasonNumber'] == season.to_s
          results << { :number => episode['EpisodeNumber'], :name => episode['EpisodeName']}
        end
        results
      end

      def episode_by_title(title, season = nil)
        show_id = @tv_db.show_id(@show)
        info = @tv_db.season_info(show_id, season)

        results = []
        info['Data']['Episode'].each do |episode|
          next if season != nil && episode['SeasonNumber'] != season.to_s
          next unless episode['EpisodeName'] =~ /#{title}/i
            results << {
            :number => episode['EpisodeNumber'],
            :name => episode['EpisodeName'],
            :season => episode['SeasonNumber']
          }
        end
        results
      end

    end
  end
end
