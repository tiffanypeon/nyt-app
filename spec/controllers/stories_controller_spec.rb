require 'rails_helper'

RSpec.describe StoriesController do

  describe '#index' do
    describe 'html response' do
      before { get :index }
      it { should render_template(:index) }
    end

    describe 'api response' do
      context 'with a GET request' do
        it 'responds with a 200' do
          get :index
          expect(response.status).to eq 200
        end
      end

      context 'with any other request' do
        it 'responds with a 403' do
          post :index
          expect(response.status).to eq 403
        end
      end
    end
  end
end
