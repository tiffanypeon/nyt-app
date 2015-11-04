require 'feature_helper'

feature 'As a visitor' do 
  scenario 'I can see the title of an article' do 
    visit stories_path
    expect(page).to have_content 'For Puerto Ricans, a Parade of Doubts'
    expect(page).to have_content 'Texas Woman Arrested in Connection With Ricin-Laced Letters'
  end
end
