require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

module TvShow
  module TvDb
    describe ShowInfo do
      it "should get the episode name of season 3 episode 10 of Fringe" do
        tv_db_api = double('The TvDb API')
        show_info = ShowInfo.new(tv_db_api)

        tv_db_api.stub(:show_id_for).and_return(82066)
        tv_db_api.stub(:show_info_for).and_return({
          'Data' => { 'Episode' => { 'EpisodeName' => 'Firefly' }}
        })

        show_info.name_by_episode("Fringe", 3, 10).should == "Firefly"
      end
    end
  end
end
