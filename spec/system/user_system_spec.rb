require 'rails_helper'

describe 'User', type: :system do
  let!(:first_user) { create(:user, email: 'day@email.com', password: 'babadoo') }
  let!(:second_user) { create(:user, name: 'Tom Hanks') }

  describe "user sign in" do
    describe 'user can sign in with valid credentials' do
      scenario 'user can sign in correctly' do
        visit new_user_session_path
        
        fill_in 'Email', with: 'day@email.com'
        fill_in 'Password', with: 'babadoo'
        click_on 'Log in'
        expect(page).to have_text('Your lists')
      end
    end

    describe "users can't sign in with invalid credentials" do
      scenario 'user can not log in with empty fields' do
        visit root_path
        expect(page).to have_current_path("/users/sign_in")

        fill_in "Email", with: ''
        fill_in "Password",	with: ''

        click_on 'Log in'
        expect(page).to have_text('Invalid Email or password')
        expect(page).to have_current_path("/users/sign_in")
      end

      scenario 'user can not log in with invalid credientials' do
        visit new_user_session_path
        
        fill_in "Email",	with: "bebe"
        fill_in 'Password', with: '1233'

        click_on 'Log in'
        expect(page).to have_text('Invalid Email or password')
      end
    end    
  end

  describe "user sign up" do
    describe "user can't sign up with invalid credentials" do
      scenario "user can't sign up with wrong email or password" do
          visit new_user_registration_path

          fill_in 'Name', with: 'Chicky Flair'
          fill_in "Email",	with: "gg@gmail.com"
          fill_in "Password",	with: "lll"

          click_on 'Sign up'
          expect(page).to have_text('Password is too short (minimum is 6 characters)')
      end

      scenario "user can't sign up with wrong email format" do
        visit new_user_registration_path

        fill_in 'Name', with: 'Chicky Flair'
        fill_in "Email",	with: "gg.gmail.com"
        fill_in "Password",	with: "justin"

        click_on 'Sign up'
        expect(page).to have_text('Email is invalid')
      end

      scenario "user can't sign up with existing email" do
        visit new_user_registration_path

        fill_in 'Name', with: 'Chicky Flair'
        fill_in "Email",	with: "day@email.com" 
        fill_in "Password",	with: "justin" 

        click_on 'Sign up'
        expect(page).to have_text('Email has already been taken')
      end
    end

    describe 'user can sign up with valid credentials' do
      it "should submit the user's sign up form" do
        visit new_user_registration_path

        fill_in 'Name', with: 'Glory Florish'
        fill_in 'Email', with: 'jj@email.com'
        fill_in 'Password', with: 'bababoo'

        click_on 'Sign up'
        expect(page).to have_current_path('/')
        expect(page).to have_text('Your lists')
      end
    end
  end
end
