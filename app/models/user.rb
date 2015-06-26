class User < ActiveRecord::Base
  attr_accessor :remember_token

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save {self.email = email.downcase}

  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                   foreign_key: "follower_id",
                                   dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  validates :name, length: {minimum: Settings.user_name_min_long, too_short: I18n.t(:user_error_too_short)}, uniqueness: true

  validates :email, length: {minimum:Settings.user_email_min_long, too_short: I18n.t(:user_error_too_short)}, uniqueness: true

  validates :password, length: {minimum: Settings.user_password_min_long, too_short: I18n.t(:user_error_too_short)}

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end
end
