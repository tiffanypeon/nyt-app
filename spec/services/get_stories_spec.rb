require 'rails_helper'

RSpec.describe GetStories do
   #TODO - stub network request
  let(:url) { 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js' }
  let(:get_stories) { GetStories.new(url)}
  let(:story) { instance_double('Story', headline: "Texas Woman Arrested in Connection With Ricin-Laced Letters") }

  describe '.call' do 
    it 'returns an array of story objects' do
      expect(get_stories.call[1].headline).to eq story.headline
    end
  end

end
