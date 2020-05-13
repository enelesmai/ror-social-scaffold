class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends = friendships.map { |f| f.friend if f.confirmed }
    friends += inverse_friendships.map { |f| f.user if f.confirmed }
    friends.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def added?(user)
    user == self ||
      Friendship.where(user: user, friend: self).exists? ||
      friendships.where(friend: user).exists?
  end

  def friends_and_own_posts
    arr = friends << self
    Post.where(user: arr).order(created_at: :desc)
  end
end
