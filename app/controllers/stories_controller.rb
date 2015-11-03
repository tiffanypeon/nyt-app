class StoriesController < ApplicationController

  def index
    binding.pry
    @stories = JSON.parse(Net::HTTP.get('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js'))
  end
end
