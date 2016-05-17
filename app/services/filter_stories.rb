class FilterStories
  def initialize(page)
    @page = page
  end

  def call
    #loop through collections and grab content that has type of 'Article'
    collections_with_assets.flatten.select do |assets|
      assets['type'] == 'Article'
    end
  end

  private
  attr_accessor :page

  def collections_with_assets
    content_with_collections.flatten.each_with_object([]) do |collection, new_array|
      if collection['assets'].present?
        new_array << collection['assets']
      end
    end
  end

  def content_with_collections
    page['content'].each_with_object([]) do |content, new_array|
      if content['collections'].present?
        new_array << content['collections']
      end
    end
  end

end
