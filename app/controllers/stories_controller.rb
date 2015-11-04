class StoriesController < ApplicationController

  def index
    uri = URI('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    binding.pry
    @stories = GetStories.call
  end
end
