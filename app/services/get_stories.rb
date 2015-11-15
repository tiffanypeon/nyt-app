class GetStories
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

  def self.image_url(story)
    unless story['images'].empty?
      story['images'][0]['types'][0]['content'] 
    end
  end

  def self.image_param(collection)
    collection[0]['images'][0]['types'][0]['content'] unless collection[0]['images'].empty?
  end

  def self.parsed_response
    uri = URI('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    JSON.parse(Net::HTTP.get(uri))['page']
  end

  def self.collections 
    parsed_response['content'].map do |response|
      response['collections'] unless response['collections'].empty?
    end
  end

  def self.contents
    contents = []
    collections.each do |collection|
      collection.each do |c|
        if !(c.nil? || c['assets'].empty?)
          contents << c['assets']
        end
      end
    end
    contents
  end

  def self.stories
    #loop through collections and grab only the ones that we want 
    #['assets'] isn't an empty array
    #['assets']['type'] is 'Article'
    articles = []
    contents.compact.each do |content_details|
      content_details.each do |content|
        if content['type'] == 'Article'
          articles << content
        end
      end
    end
    articles
  end

end
