class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :authentications_attributes
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

#  validates_length_of :password, minimum: 3, message: "password must be at least 3 characters long", if: :password
#  validates_confirmation_of :password, message: "should match confirmation", if: :password

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
end