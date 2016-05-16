require 'feature_helper'

feature 'As a visitor' do
  scenario 'I can see the title of an article' do
    visit stories_path
    expect(page).to have_content 'For Puerto Ricans, a Parade of Doubts'
  end

  context 'choosing my language' do
    scenario 'By default' do
      visit stories_path
      expect(page).to have_content 'For Puerto Ricans'
    end

    scenario 'I can change to martian language' do
      binding.pry
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

  describe 'Viewing older stories' do
    before do
      WebMock.disable!
    end

    after do
      WebMock.enable!
    end

    scenario 'I can load older stories onto the page', js: true do
      visit stories_path
      click_on 'Older stories'
      expect(page).to have_content 'Political Leaders Gather to Pay Tribute to Lautenberg'
    end

    scenario 'The stories will load in my language', js: true do
      visit stories_path
      click_on 'Martian'
      click_on 'Older stories'
      expect(page).not_to have_content 'Political Leaders Gather to Pay Tribute to Lautenberg'
    end
  end
end
