class Story
  attr_reader :headline, :byline, :url, :summary, :image, :last_published

  IMAGE_URL = 'https://graphics8.nytimes.com/'

  def initialize(opts={})
    @headline = opts[:headline]
    @byline = opts[:byline]
    @url = opts[:url]
    @summary = opts[:summary]
    @image = opts[:image]
    @last_published = opts[:last_published]
  end

  def publish_date
    last_published.to_time.strftime("%-m/%-d/%Y")
  end

  def image_url
    if image.empty?
      ''
    else
      URI.join(IMAGE_URL, image[0]['types'][0]['content'])
    end
  end
end
