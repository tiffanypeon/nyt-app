class ArticleFilter
  def initialize(response)
    @response = response
  end

  def call
    #loop through collections and grab content that has type of 'Article'
    contents_with_assets.select do |content_details|
      content_details['type'] == 'Article'
    end
  end

  private
  attr_accessor :response

  def collections_with_details
    response['content'].map do |content_block|
      unless content_block['collections'].empty?
        content_block['collections']
      end
    end
  end

  def contents_with_assets
    contents = []
    collections_with_details.each do |collection_array|
      collection_array.each do |collection|
        if !(collection.nil? || collection['assets'].empty?)
          contents << collection['assets']
        end
      end
    end
    contents.flatten
  end

end
