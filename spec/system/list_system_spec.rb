require 'rails_helper'

describe 'List', type: :system do
  let!(:user) { create(:user, name: 'Rebecca Friday') }
  let!(:first_list) { create(:list, title: 'Basket ball', user_id: user.id) }
  let!(:second_list) { create(:list, title: 'Golf', user_id: user.id) }
  let!(:first_list_task) { create(:task, description: 'get the basket ball', list_id: first_list.id) }
  let!(:second_list_task) { create(:task, description: 'get the golf ball', list_id: second_list.id) }

  describe "logged in users" do
    before { login user }
    context 'can perform actions with valid parameters' do
      scenario 'user can add their lists to the list table' do
        expect(page).to have_content('Basket ball')

        click_on 'Add a list'
        fill_in 'Title', with: 'Football'
        click_on 'Create List'
        expect(page).to have_content('Football')
      end

      scenario 'user can update the list' do
        within first(".links") do
          click_link "Edit"
        end

        expect(page).to have_current_path("/lists/#{second_list.id}/edit")

        fill_in 'Title', with: 'Clean house'

        click_on 'Update List'

        expect(page).not_to have_content('Golf')
        expect(page).to have_content('Clean house')
      end

      context 'user can add tasks to their list' do
        scenario 'in the index page' do
          within first(".links") do
            click_link 'Add task'
          end
          
          fill_in 'Description', with: 'Cook'
          click_on 'Create Task'

          expect(page).to have_current_path("/lists/#{second_list.id}")
        end

        scenario 'in the show page' do
          visit list_path(second_list)

          click_on 'Add a task'
          fill_in 'Description', with: 'Cook'
          click_on 'Create Task'

          expect(page).to have_current_path("/lists/#{second_list.id}")
        end
      end

      scenario 'user can view the tasks in their list' do
        within first(".links") do
          click_link 'Show'
        end

        expect(page).to have_current_path("/lists/#{second_list.id}")
        expect(page).to have_content('Add a task')
        expect(page).to have_content('Back to lists')
        expect(page).to have_content('Golf')
        expect(page).to have_content('get the golf ball')
      end

      scenario 'user can delete list' do
        within first(".links") do
          click_link 'Delete'
        end

        expect(page).not_to have_content(second_list.title)
      end
    end

    context 'can not perform action with invalid parameters' do
      scenario 'user can not add a list without inputing title name' do
        click_on 'Add a list'
        fill_in 'Title', with: ''
        click_on 'Create List'

        expect(page).to have_content("Title can't be blank")
      end

      scenario 'user can not update a list without inputing a title' do
        within first(".links") do
          click_link 'Edit'
        end
        
        fill_in 'Title', with: ''
        click_on 'Update List'

        expect(page).to have_content("Title can't be blank")
      end
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
