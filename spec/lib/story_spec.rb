require 'rails_helper'

RSpec.describe Story, type: :model do 
  it { should respond_to :headline }
  it { should respond_to :byline }
  it { should respond_to :url }
  it { should respond_to :summary }
  it { should respond_to :image }
  it { should respond_to :last_published }

  describe '.to_martian' do
    let(:story) { Story.new({ 
      headline: "Texas woman Arrested in Connection With Ricin-Laced Letters"
    })}

    it 'leaves every word three characters or less alone' do
      expect(story.martian_headline).to match /in/
    end

   it 'replaces every word more than three characters with boinga ' do
      expect(story.martian_headline).to match /Boinga/
   end

    it 'maintains the same capitalization and punctuation' do 
      expect(story.martian_headline).to match /Boinga-Boinga/
    end
  end

end
