class Story
  attr_reader :headline, :byline, :url, :summary, :image, :last_published

  def initialize(opts={})
    @headline = opts[:headline]
    @byline = opts[:byline]
    @url = opts[:url]
    @summary = opts[:summary]
    @image = opts[:image]
    @last_published = opts[:last_published]
  end
end
