class StoriesController < ApplicationController

  def index
    @full_stories, @other_stories = stories.partition do |story|
      story.image.present?
    end
  end

  def older

  end

  private

  def stories
    url = ('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    @stories ||= GetStories.new(url).call
  end

end

