require 'rails_helper'

RSpec.describe GetStories do
  let(:story_1) { Story.new(
    {
      headline:  "Texas Woman Arrested in Connection With Ricin-Laced Letters",
      byline:  "By JOSEPH GOLDSTEIN",
      url: "http://www.nytimes.com/2013/06/08/nyregion/texas-woman-arrested-in-connection-with-ricin-laced-letters.html",
      summary: "Shannon Richardson was accused of mailing threatening communications to President Obama, Mayor Michael R. Bloomberg and a lobbyist, according to officials.",
      image: nil,
      last_published: "2013-06-07T14:09:27.027.EDT"
    }
  )}

  describe '.call' do 
    xit 'returns an array of story objects' do
      expect(GetStories.call).to include story_1
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
      expect(GetStories.stories).to include 'foo'
    end
  end
end
