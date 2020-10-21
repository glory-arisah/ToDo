require 'rails_helper'

describe 'List', type: :system do
  let!(:user) { create(:user, first_name: 'Jide') }
  let!(:first_list) { create(:list, title: 'Basket ball', user_id: user.id) }
  let!(:second_list) { create(:list, title: 'Golf', user_id: user.id) }
  let!(:first_list_task) { create(:task, description: 'get the basket ball', list_id: first_list.id) }
  let!(:second_list_task) { create(:task, description: 'get the golf ball', list_id: second_list.id) }

  context "logged in users" do
    before { login user }
    scenario 'can add their lists to the list table' do
      expect(page).to have_content('Basket ball')

      click_on 'Add a list'
      fill_in 'Title', with: 'Football'
      click_on 'Create List'
      expect(page).to have_content('Football')
    end

    scenario 'can update their list' do
      within first(".links") do
        click_link "Edit"
      end

      expect(page).to have_current_path("/lists/#{second_list.id}/edit")

      fill_in 'Title', with: 'Clean house'

      click_on 'Update List'

      expect(page).not_to have_content('Golf')
      expect(page).to have_content('Clean house')
    end

    scenario 'can view the tasks in their list' do
      within first(".links") do
        click_link 'Show'
      end

      expect(page).to have_current_path("/lists/#{second_list.id}")
      expect(page).to have_content('Golf')
      expect(page).to have_content('get the golf ball')
    end
  end

  context "non-logged in users" do
    scenario 'can not add their lists to the list table' do
      visit root_path

      expect(page).to have_current_path('/users/sign_in')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    scenario 'can not update their lists' do
      visit edit_list_path(second_list)
     
      expect(page).to have_current_path('/users/sign_in')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    scenario 'can not view the tasks in their list' do
      visit list_path(second_list)

      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end
  end
end
