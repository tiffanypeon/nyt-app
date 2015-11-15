require 'rails_helper'

RSpec.describe ArticleFilter do 
  describe '.call' do 

    #TODO - stub this obj and pull response into network stub to remove :send smell
    url = 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js'
    parsed_response = GetStories.new(url).send(:parsed_response)

    article_filter = ArticleFilter.new(parsed_response)

    it 'returns an array of stories' do
      expect(article_filter.call.size).to eq 19
    end
  end

end
