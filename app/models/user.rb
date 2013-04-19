class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :authentications_attributes, :avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/system/missing/:style/missing.jpg"
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :username,
    presence: true,
    uniqueness: true
  validates :email,
    presence: true,
    uniqueness: true
  validates :password,
    length: { minimum: 3, message: "password must be at least 3 characters long", if: :password },
    confirmation: { message: "should match confirmation", if: :password }
  validates_attachment :avatar, presence: true,
    content_type: { content_type: ["image/jpg", "image/png"] },
    size: { less_than: 2.megabytes }

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
end