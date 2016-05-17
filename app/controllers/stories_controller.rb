class StoriesController < ApplicationController

  def index
    @full_stories, @other_stories = stories.partition do |story|
      story.image.present?
    end
  rescue
    render :error
  end

  private

  def stories
    GetStories.call
  end

end

