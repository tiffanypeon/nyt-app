class GetStories
  def self.call
    stories = []
    collections = []
    stories_json #.merge(story_json['content'][2]) ? 
    collections_json.each do |collection|
      collections << collection['assets']  #if assets isn't nil 
    end
    collections.each do |collection|
      binding.pry
      if !collection.empty?
        stories << Story.new(
          headline: collection[0]['headline'],
          byline: collection[0]['byline'],
          url: collection[0]['url'],
          summary: collection[0]['summary'],
          image: image_param(collection),
          last_published: collection[0]['lastPublished']
        )
      end
    end
    stories
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
    collections.each_with_index.map do |collection, i|
      if !(collection[i].nil? || collection[i]['assets'].empty?)
        collection[i]['assets']
      end
    end
  end

  def self.stories
    #loop through collections and grab only the ones that we want 
    #['assets'] isn't an empty array
    #['assets']['type'] is 'Article'
    contents.compact.each_with_index.select do |content_details, i|
      content_details[i]['type'] == 'Article'
    end
  end

end
