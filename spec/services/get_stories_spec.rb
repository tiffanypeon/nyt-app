require 'rails_helper'

RSpec.describe GetStories do
  let(:url) { 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js' }
  let(:story) { instance_double('Story', headline: "For Puerto Ricans, a Parade of Doubts") }

  describe '#call' do
    it 'returns an array of story objects' do
      expect(GetStories.call[0].headline).to eq story.headline
    end
  end

end
