class FriendshipsController < ApplicationController
  def index
    @friendship_requests = Friendship.where(friend: current_user, confirmed: nil)
  end

  def create
    @friend = User.find(params[:user])

    current_user.friendships.create(friend: @friend)
    redirect_to request.referrer
  end

  def update
    @friendship = Friendship.find(params[:id])

    if params[:confirmed] == 'true'
      @friendship.accept
      current_user.friendships.create(friend: @friendship.user, confirmed: true)
      flash.notice = 'Friendship was accepted'
    else
      @friendship.destroy
      flash.notice = 'Friendship was declined'
    end
    redirect_to request.referrer
  end
end
