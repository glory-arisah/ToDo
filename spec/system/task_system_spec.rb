require 'rails_helper'

describe 'Task', type: :system, js: true do
  let(:user) { create(:user) }
  let(:house_cleaning) { create(:list, title: 'environmental', user: user) }
  let(:break_time) { create(:list, title: 'sleep', user_id: user.id) }
  let!(:house_cleaning_task) { create(:task, description: 'wash the toilet', list_id: house_cleaning.id) }
  let!(:gaming_break_time_task) { create(:task, description: 'play games', list_id: break_time.id) }
  let!(:yoga_break_time_task) { create(:task, description: 'do some yoga', list_id: break_time.id) }

  describe "logged in users" do
    before { login user }
    context 'can perform actions with valid parameters' do
      context 'create task in the root page and in the list show page'
        scenario 'can create tasks in the root page' do
          within first(".links") do
            click_link 'Add task'
          end
          expect(page).to have_current_path(root_path)
          fill_in 'Description', with: 'Living room'
          click_on 'Create Task'

          expect(page).to have_content('Living room')
        end

        scenario 'can create tasks in the list show page' do
          visit list_path(break_time)
          click_link 'Add a task'
          fill_in 'Description', with: 'do stretches'
          click_on 'Create Task'

          expect(page).to have_content('do stretches')
        end

      scenario 'can update their task' do
        visit list_path(break_time)        
        first(:css, ".edit-icon").click
        expect(page).to have_current_path("/lists/#{break_time.id}") 
        expect(page).to have_content('play games')

        fill_in 'Description', with: 'start with the veranda'
        click_on 'Update Task'
        expect(page).to have_content('start with the veranda')
      end

    scenario 'can delete their task' do
      visit list_path(break_time)
      first(:css, ".delete-icon").click
      expect(page).not_to have_content(gaming_break_time_task)
    end
  
    scenario "can update tasks' check status" do
      visit list_path(break_time)
      expect do
        check("task_id_#{gaming_break_time_task.id}")
        wait_for_ajax
      end.to change { gaming_break_time_task.reload.task_check }.from(false).to(true)
    end
  end

    context 'can not perform action with invalid parameters' do
      scenario 'user can not create a task without inputing description' do
        visit list_path(break_time)
        click_on 'Add a task'
        fill_in "Description",	with: ""
        click_on 'Create Task'

        expect(page).to have_content("Description can't be blank")
      end

      scenario 'user can not update a task without inputing description' do
        visit list_path(break_time)
        first(:css, ".edit-icon").click
        
        fill_in "Description",	with: "" 
        click_on 'Update Task'

        expect(page).to have_content("Description can't be blank")
      end
    end
  end
  
  context "non-logged in users" do
    scenario 'can not create tasks' do
      visit "/lists/#{house_cleaning.id}/tasks/new"

      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    scenario 'can not update their tasks' do
      visit "/lists/#{house_cleaning.id}/tasks/#{house_cleaning_task.id}/edit"

      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end
  end
end
