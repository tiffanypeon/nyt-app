class StoriesController < ApplicationController

  def index
    url = ('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    
    @stories = GetStories.new(url).call
  end
end

