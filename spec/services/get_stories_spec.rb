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

end
