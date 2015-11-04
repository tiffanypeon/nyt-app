class GetStories
  def self.call
    stories = []
    collections = []
    uri = URI('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js')
    story_json = JSON.parse(Net::HTTP.get(uri))['page']
    collections_json = story_json['content'][1]['collections'] #.merge(story_json['content'][2]) ? 
    collections_json.each do |collection|
      collections << collection['assets']
    end
    collections.each do |collection|
      stories << Story.new(
        headline: collection[0]['headline'],
        byline: collection[0]['byline'],
        url: collection[0]['url'],
        summary: collection[0]['summary'],
        image: collection[0]['images'][0]['types'][0]['content'],
        last_published: 
      )
  end
end
