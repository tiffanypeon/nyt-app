require 'rails_helper'

RSpec.describe FilterStories do
  let(:network_response) { File.read(Rails.root.join('spec/stubbed_responses/newest_articles.json')) }
  let(:parsed_response) { JSON.parse(network_response)['page'] }

  describe '.call' do
    let(:filter_stories) { FilterStories.new(parsed_response) }

    it 'returns an array of articles' do
      expect(filter_stories.call.size).to eq 2
    end
  end

end
