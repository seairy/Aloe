class Permission < ActiveRecord::Base
  belongs_to :role
  validates :controller_name, presence: true, length: { maximum: 50 }
  validates :action_name, presence: true, length: { maximum: 50 }
end
