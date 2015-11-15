require 'rails_helper'

RSpec.describe GetStories do
  let(:story_1) { Story.new(
    {
      byline:  "By JOSEPH GOLDSTEIN",
      headline:  "Texas Woman Arrested in Connection With Ricin-Laced Letters",
      image: nil,
      last_published: "2013-06-07T14:09:27.027.EDT",
      summary: "Shannon Richardson was accused of mailing threatening communications to President Obama, Mayor Michael R. Bloomberg and a lobbyist, according to officials.",
      url: "http://www.nytimes.com/2013/06/08/nyregion/texas-woman-arrested-in-connection-with-ricin-laced-letters.html"
    }
  )}

  describe '.call' do 
    it 'returns an array of story objects' do
      stories = GetStories.call
      expect(stories[1].headline).to eq story_1.headline
    end
  end

  describe '.collections' do 
    let(:collection) {[{"id"=>89137755,
    "name"=>"LiveMobileResults",
    "renderStyle"=>"",
    "rank"=>1,
    "excludedFromFeed"=>false,
    "parameters"=>{"kicker"=>""},
    "assets"=>[]}]}

    it 'returns an array of collections' do 
      expect(GetStories.collections).to include collection
    end
  end

  describe '.contents' do 
    it 'returns an array of contents' do 
      expect(GetStories.contents).not_to include []
    end
  end

  describe '.stories' do 
    it 'returns an array of stories' do
      expect(GetStories.stories.size).to eq 19
    end
  end
end
