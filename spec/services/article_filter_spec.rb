require 'rails_helper'

RSpec.describe ArticleFilter do 
  url = 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js'
  let(:parsed_response) { GetStories.new(url).parsed_response }
  let(:article_filter) { ArticleFilter.new(parsed_response) }

  describe '.call' do 
    it 'returns an array of stories' do
      expect(article_filter.call.size).to eq 19
    end
  end

  describe '.collections_with_details' do 
    let(:collection) {[{"id"=>89137755,
    "name"=>"LiveMobileResults",
    "renderStyle"=>"",
    "rank"=>1,
    "excludedFromFeed"=>false,
    "parameters"=>{"kicker"=>""},
    "assets"=>[]}]}

    it 'removes nodes with empty collections' do 
      expect(article_filter.collections_with_details).not_to include []
    end

    it 'returns nodes with collections that have details' do 
       expect(article_filter.collections_with_details).to include collection
    end
  end

  describe '.contents_with_assets' do 
    it 'removes nodes with empty assets' do 
      expect(article_filter.contents_with_assets).not_to include []
    end

    it 'returns nodes with assets that have details' do 
      expect(article_filter.contents_with_assets.first['id']).to eq 100000002264788
    end
  end

end
