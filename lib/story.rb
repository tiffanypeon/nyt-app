class Story
  attr_reader :headline, :byline, :url, :summary, :image, :last_published, :martian_headline, :martian_byline, :martian_summary

  def initialize(opts={})
    @headline = opts[:headline]
    @byline = opts[:byline]
    @url = opts[:url]
    @summary = opts[:summary]
    @image = opts[:image]
    @last_published = opts[:last_published]
    @martian_headline = to_martian(headline) if headline
    @martian_byline = to_martian(byline) if byline
    @martian_summary = to_martian(summary) if summary
  end

  def to_martian(text)
    text.gsub(/[\w']{4,}/) do |word|
      if word[0] == word[0].capitalize
        'Boinga'
      else
        'boinga'
      end
    end
  end
  
end
