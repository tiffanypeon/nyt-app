require 'feature_helper'

feature 'As a visitor' do 
  scenario 'I can see the title of an article' do 
    visit stories_path
    expect(page).to have_content 'New York Region News'
  end
end
