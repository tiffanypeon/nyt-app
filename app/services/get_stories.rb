class GetStories
  attr_reader :uri

  def initialize(url)
    @uri = URI(url)
  end

  def call
    stories = []
    articles.each do |story|
      stories << Story.new({
        headline: story['headline'],
        byline: story['byline'],
        url: story['url'],
        summary: story['summary'],
        image: image_url(story),
        last_published: story['lastPublished']
      })
    end

    stories
  end

  def parsed_response
    JSON.parse(Net::HTTP.get(uri))['page']
  end

  private

  def articles
    ArticleFilter.new(parsed_response).call
  end

  def image_url(story)
    unless story['images'].empty?
      story['images'][0]['types'][0]['content'] 
    end
  end

end
