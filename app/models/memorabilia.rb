class Memorabilia < ActiveRecord::Base
  scope :sorted, -> { order('year DESC') }
end
