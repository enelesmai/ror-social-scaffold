require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  scenario 'decline friendship' do
    @user =
      User.new(
        name: 'User', email: 'user@email.com',
        password: '123123123', password_confirmation: '123123123'
      )
    @user.save
    @friend =
      User.new(
        name: 'Friend', email: 'friend@email.com',
        password: '123123123', password_confirmation: '123123123'
      )
    @friend.save
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user@email.com'
    fill_in 'user_password', with: '123123123'
    click_button 'Log in'

    visit "/users/#{@friend.id}"
    click_link 'Invite to friendship'

    click_link 'Sign out'

    visit '/users/sign_in'
    fill_in 'user_email', with: 'friend@email.com'
    fill_in 'user_password', with: '123123123'
    click_button 'Log in'

    visit 'friendships'

    click_link 'Decline'

    expect(page).to have_text('Friendship was declined')
  end
end
