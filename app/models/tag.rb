class Tag < ActiveRecord::Base
  belongs_to :post
  attr_accessible :name
  validates :name, presence: true
end
