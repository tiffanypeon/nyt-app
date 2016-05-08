require 'feature_helper'

feature 'As a visitor' do
  scenario 'I can see the title of an article' do
    visit stories_path
    expect(page).to have_content 'For Puerto Ricans, a Parade of Doubts'
    expect(page).to have_content 'Texas Woman Arrested in Connection With Ricin-Laced Letters'
  end

  context 'choosing my language' do
    scenario 'By default' do
      visit stories_path
      expect(page).to have_content 'For Puerto Ricans'
    end

    scenario 'I can change to martian language' do
      visit stories_path
      click_on 'Martian'
      expect(page).to have_content 'boinga'
    end

    scenario 'I can change back to English' do
      visit stories_path
      click_on 'Martian'
      click_on 'English'
      expect(page).not_to have_content 'boinga'
    end
  end
end
