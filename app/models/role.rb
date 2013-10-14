class Role < ActiveRecord::Base
  has_many :administrators
  has_many :permissions
  validates :name, presence: true, length: { maximum: 50 }
end
