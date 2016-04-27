class StoriesController < ApplicationController
  before_action :get_stories, only: :index

  def index
    if language_params[:martian]
      @stories.martianize
    else
      @stories.english
    end
  end

  def get_stories
    url = ('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    
    @stories = GetStories.new(url).call
  end

  private

  def language_params
    params.require(:story).permit(:language)
  end

end

