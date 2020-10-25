require "rails_helper"

describe "List", type: :system, js: true do
  let(:user) { create(:user) }
  let(:house_cleaning) { create(:list, title: "environmental", user: user) }
  let(:break_time) { create(:list, title: "sleep", user: user) }
  let!(:house_cleaning_task) { create(:task, description: "wash the toilet", list_id: house_cleaning.id) }
  let!(:gaming_break_time_task) { create(:task, description: "play games", list_id: break_time.id) }
  let!(:yoga_break_time_task) { create(:task, description: "do some yoga", list_id: break_time.id) }

  describe "logged in users" do
    before { login user }
    context "can perform actions with valid parameters" do
      scenario "user can add their lists to the list table" do
        click_on "Add a list"

        fill_in "Title", with: "Football"
        click_on "Create List"
        expect(page).to have_content("Football")
      end

      scenario "user can update the list" do
        within first(".links") do
          click_link "Edit"
        end

        expect(page).to have_current_path(root_path)

        fill_in "Title", with: "Clean house"

        click_on "Update List"

        expect(page).not_to have_content("play games")
        expect(page).to have_content("Clean house")
      end

      context "user can add tasks to their list" do
        scenario "in the index page" do
          within first(".links") do
            click_link "Add task"
          end

          fill_in "Description", with: "Cook"
          click_on "Create Task"

          expect(page).to have_current_path("/lists/#{break_time.id}")
        end

        scenario "in the show page" do
          visit list_path(break_time)

          click_on "Add a task"
          fill_in "Description", with: "Cook"
          click_on "Create Task"

          expect(page).to have_current_path("/lists/#{break_time.id}")
          expect(page).to have_content('Cook')
        end
      end

      scenario "user can view the tasks in their list" do
        within first(".links") do
          click_link "Show"
        end

        expect(page).to have_current_path("/lists/#{break_time.id}")
        expect(page).to have_content("sleep")
        expect(page).to have_content("play games")
        expect(page).to have_content("do some yoga")
        expect(page).to have_content("Add a task")
        expect(page).to have_content("Back to lists")
      end

      scenario "user can delete list" do
        within first(".links") do
          click_link "Delete"
        end
        click_on "Delete"
        expect(page).not_to have_content('sleep')
        expect(page).not_to have_content('environmental')
        expect(page).to have_content('You do not have any list')
      end
    end

    context "can not perform action with invalid parameters" do
      scenario "user can not add a list without inputing title name" do
        click_on "Add a list"
        fill_in "Title", with: ""
        click_on "Create List"

        expect(page).to have_content("Title can't be blank")
      end

      scenario "user can not update a list without inputing a title" do
        within first(".links") do
          click_link "Edit"
        end

        fill_in "Title", with: ""
        click_on "Update List"

        expect(page).to have_content("Title can't be blank")
      end
    end
  end

  context "non-logged in users" do
    scenario "can not add their lists to the list table" do
      visit root_path

      expect(page).to have_current_path("/users/sign_in")
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end

    scenario "can not update their lists" do
      visit edit_list_path(break_time)

      expect(page).to have_current_path("/users/sign_in")
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end

    scenario "can not view the tasks in their list" do
      visit list_path(break_time)

      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
    end
  end
end
