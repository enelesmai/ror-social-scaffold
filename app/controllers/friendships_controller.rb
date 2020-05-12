class FriendshipsController < ApplicationController
  def index
    @friendship_request = Friendship.where(friend: current_user, confirmed: nil)
  end

  def create
    @friend = User.find(params[:user])

    current_user.friendships.create(friend: @friend)
    redirect_to request.referrer
  end

  def update
    @friendship = Friendship.find(params[:id])

    if params[:confirmed] == true
      @friendship.accept
    else
      @friendship.destroy
    end
    redirect_to request.referrer
  end
end
