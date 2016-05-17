module GetStories
  extend self

  STORIES_URI = URI('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')

  def call
    stories.map do |story|
      Story.new({
        headline: story['headline'],
        byline: story['byline'],
        url: story['url'],
        summary: story['summary'],
        image: story['images'],
        last_published: story['lastPublished']
      })
    end
  end

  private

  def stories
    FilterStories.new(parsed_response).call
  end

  def parsed_response
    JSON.parse(Net::HTTP.get(STORIES_URI))['page']
  end

end
