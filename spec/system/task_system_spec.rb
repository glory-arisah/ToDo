require 'rails_helper'

describe 'Task', type: :system do
  let!(:user) { create(:user) }
  let!(:first_list) { create(:list, title: 'Gaming', user_id: user.id) }
  let!(:second_list) { create(:list, title: 'Cleaning', user_id: user.id) }
  let!(:first_list_task1) { create(:task, description: 'play ps4', list_id: first_list.id) }
  let!(:second_list_task1) { create(:task, description: 'start with the bathroom', list_id: second_list.id) }

  context "logged in users" do
    before { login user }

    scenario 'can create tasks' do
      within first(".links") do
        click_link 'Add task'
      end

      expect(page).to have_current_path("/lists/#{second_list.id}/tasks/new")
      
      fill_in 'Description', with: 'Living room'
      
      expect do
        click_on 'Create Task'
      end.to change(Task, :count).by(1)
    end

    scenario 'can update their task' do
      visit list_path(second_list)
      within first(".task_links") do
        click_link 'Edit'
      end

      expect(page).to have_current_path("/lists/#{second_list.id}/tasks/#{second_list_task1.id}/edit") 
      expect(page).to have_content('start with the bathroom')

      fill_in 'Description', with: 'start with the veranda'
      click_on 'Update Task'
      expect(page).to have_content('start with the veranda')
    end

    scenario "can update tasks' check status", js: true do
      visit list_path(second_list)
pp 'test'
    # page.check("task_#{second_list_task1.id}", name: "task[#{second_list_task1.id}]", allow_label_click: true)
      pp second_list_task1.task_check
      check "task_#{second_list_task1.id}"
      second_list_task1.reload
      pp second_list_task1.task_check
      expect(second_list_task1.task_check).to be(true)
    end
  end
  
  context "non-logged in users" do
    scenario 'can not create tasks' do
      visit "/lists/#{first_list.id}/tasks/new"

      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    scenario 'can not update their tasks' do
      visit "/lists/#{first_list.id}/tasks/#{first_list_task1.id}/edit"

      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

  end
end
