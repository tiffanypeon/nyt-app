require 'rails_helper'

RSpec.describe ArticleFilter do
  let(:network_response) { File.read(Rails.root.join('spec/stubbed_responses/newest_articles.json')) }
  let(:parsed_response) { JSON.parse(network_response)['page'] }

  describe '.call' do
    let(:article_filter) { ArticleFilter.new(parsed_response) }

    it 'returns an array of articles' do
      expect(article_filter.call.size).to eq 2
    end
  end

end
