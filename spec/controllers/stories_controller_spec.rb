require 'rails_helper'

RSpec.describe StoriesController, type: :controller do

  describe '#index' do 
    describe 'html response' do
      before { get :index }
      it { should render_template(:index) } 
    end

    describe 'language toggle' do 
      let(:story_1) { instance_double(Story, martianize: true, english: true) }
      let(:story_2) { instance_double(Story, martianize: true, english: true) }
      let(:stories) { [ story_1, story_2 ]}

      before do
        allow(controller).to receive(:get_stories) { stories }
      end

      context 'with no query params' do 
        it 'defaults to English' do 
          get :index
          expect(story_1).to receive(:english)
        end
      end

      context 'with english query params' do
        it 'responds with standard stories' do 
          get :index, params: { language: 'english' }
          expect(story_1).to receive(:martian)
        end
      end

      context 'with martian query params' do 
        it 'responds with martianized stories' do 
        end
      end
    end

    describe 'api response' do 
      context 'with a GET request' do 
        it 'responds with a 200' do 
        end
      end

      context 'with any other request' do 
        it 'responds with a 403' do
        end
      end
    end
  end
end
