require 'rails_helper'

RSpec.describe User, type: :model do
  let!('user') { User.create(id: 998, name: 'user one', password: '123', email: 'user1@email.com') }
  let!('friend') { User.create(id: 999, name: 'a friend', password: '123', email: 'friend@email.com') }
  describe 'create' do
    it 'creates a new user object when input is valid' do
      expect(user).to be_a_new(User)
    end
  end
  describe 'creates a new friendship association between two users' do
    it 'returns true if friendship is confirmed' do
      user.friendships.build(friend: friend, confirmed: true)
      expect(user.friend?(friend)).to be(true)
    end
    it 'returns false if friendship is not confirmed' do
      user.friendships.build(friend: friend, confirmed: false)
      expect(user.friend?(friend)).to be(false)
    end
  end
  describe 'show friendships' do
    it 'returns a list of friends' do
      user.friendships.build(friend: friend, confirmed: true)
      expect(user.friends).to be_a(Enumerable)
    end
  end
end
