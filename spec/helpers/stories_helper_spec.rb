require 'rails_helper'

RSpec.describe StoriesHelper, type: :helper do
  let(:headline) { 'Texas woman Arrested in Connection With Ricin-Laced Letters' }
  describe '.language' do
    context 'with English language' do
      let(:params) {{ language: 'English' }}

      before { allow(helper).to receive(:params) { params } }

      it 'returns Martian' do
        expect(language).to eq 'Martian'
      end
    end

    context 'with Martian language' do
      let(:params) {{ language: 'Martian' }}

      before { allow(helper).to receive(:params) { params } }

      it 'returns English' do
        expect(language).to eq 'English'
      end
    end
  end

  describe '.toggleable_text' do

    context 'with English language' do
      it 'leaves text as is' do
        expect(toggleable_text(headline)).to match /Texas/
      end
    end

    context 'with Martian language' do
      let(:params) {{ language: 'Martian' }}

      before { allow(helper).to receive(:params) { params } }

      it 'leaves every word three characters or less alone' do
        expect(toggleable_text(headline)).to match /in/
      end

     it 'replaces every word more than three characters with boinga ' do
        expect(toggleable_text(headline)).to match /Boinga/
     end

      it 'maintains the same capitalization and punctuation' do
        expect(toggleable_text(headline)).to match /Boinga-Boinga/
      end
    end
  end
end
