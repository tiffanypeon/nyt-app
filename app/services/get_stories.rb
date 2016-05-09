class GetStories
  IMAGE_URL = 'https://graphics8.nytimes.com/'

  def initialize(url)
    @uri = URI(url)
  end

  def call
    articles.map do |story|
      Story.new({
        headline: story['headline'],
        byline: story['byline'],
        url: story['url'],
        summary: story['summary'],
        image: image_url(story),
        last_published: story['lastPublished'].to_time.to_formatted_s(:short)
      })
    end
  end

  def parsed_response
    JSON.parse(Net::HTTP.get(uri))['page']
  end

  private
  attr_reader :uri

  def articles
    ArticleFilter.new(parsed_response).call
  end

  def image_url(story)
    if story['images'].empty?
      ''
    else
      IMAGE_URL + story['images'][0]['types'][0]['content']
    end
  end

end
