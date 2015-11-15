class GetStories
  attr_reader :uri

  def initialize(url)
    @uri = URI(url)
  end
  
  def self.call
    articles = []
    stories.each do |story|
      articles << Story.new({
        headline: story['headline'],
        byline: story['byline'],
        url: story['url'],
        summary: story['summary'],
        image: image_url(story),
        last_published: story['lastPublished']
      }
      )
    end
    articles
  end

  def image_url(story)
    unless story['images'].empty?
      story['images'][0]['types'][0]['content'] 
    end
  end

  def parsed_response
    JSON.parse(Net::HTTP.get(uri))['page']
  end

end
