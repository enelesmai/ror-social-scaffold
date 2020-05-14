require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  scenario 'invite to friendship' do
    @user =
      User.new(
        name: 'User',
        email: 'user@email.com',
        password: '123123123',
        password_confirmation: '123123123'
      )
    @user.save
    @friend =
      User.new(
        name: 'Friend',
        email: 'friend@email.com',
        password: '123123123',
        password_confirmation: '123123123'
      )
    @friend.save
    visit 'users/sign_in'
    fill_in 'user_email', with: 'user@email.com'
    fill_in 'user_password', with: '123123123'
    click_button 'Log in'

    visit "users/#{@friend.id}"
    click_link 'Invite to friendship'

    expect(page).not_to have_text('Invite to friendship')
  end
end
