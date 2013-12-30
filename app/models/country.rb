# -*- encoding : utf-8 -*-
class Country < ActiveRecord::Base
  belongs_to :continent
  has_many :members
  scope :available, joins(:members).group('countries.id').having('count(members.id) > 0')
  
  def name_with_pinyin
    "#{PinYin.sentence(self.name)[0..0].upcase} - #{self.name}"
  end
  
  class << self
    def sorted_by_pinyin
      Hash[self.all.map{|c| [PinYin.sentence(c.name), c]}].sort.inject([]){|r, a| r << a[1]}
    end
  end
end
