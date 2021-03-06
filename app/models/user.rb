class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one :userdetail, dependent: :destroy
  accepts_nested_attributes_for :userdetail, allow_destroy: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friend_sent , class_name: 'Friendship' ,
          foreign_key: 'sent_by_id',
          inverse_of: 'sent_by',dependent: :destroy
  has_many :friend_request ,class_name: 'Friendship',
          foreign_key: 'sent_to_id',
          inverse_of: 'sent_to',dependent: :destroy
  has_many :friends_a_to_b, -> {  Friendship.friends },
          through: :friend_sent,source: :sent_to
  has_many :friends_b_to_a, -> { Friendship.friends },
          through: :friend_request,source: :sent_by
  has_many :pending_requests, -> { Friendship.not_friends },
          through: :friend_sent, source: :sent_to
  has_many :received_requests, -> { Friendship.not_friends },
          through: :friend_request, source: :sent_by

  def all_friends
    (friends_a_to_b+friends_b_to_a).uniq
  end
  #for search features
  def self.search(searchstring)
    searchstring.strip!
    first=match('email',searchstring)
    second=match('first_name',searchstring)
    third=match('last_name',searchstring)
    result = (first+second+third).uniq
    result
  end

  def self.match(fieldname,searchstring)
    where("#{fieldname} like ?","%#{searchstring}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id==self.id }
  end

  def full_name
    # first_name+" "+last_name
    "#{first_name} #{last_name}"
  end

  def with_userdetail
    build_userdetail if userdetail.nil?
    self
  end

  # def self.test
  #   where(first_name: "Rahul")
  # end
  # scope :testing, -> { where(first_name: "Rahul") }

end
