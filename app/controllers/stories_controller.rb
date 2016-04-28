class StoriesController < ApplicationController

  def index
    @full_stories = stories.select { |s| !s.image.empty? }
    @other_stories = stories.select { |s| s.image.empty? }
  end

  private
  def stories
    url = ('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    @stories ||= GetStories.new(url).call
  end
end

