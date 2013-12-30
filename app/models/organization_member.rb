# -*- encoding : utf-8 -*-
require 'ruby-pinyin'
class OrganizationMember < Member
  
  class << self
    def sorted_by_pinyin
      Hash[self.all.map{|m| [PinYin.sentence(m.chinese_name), m]}].sort.inject([]){|r, a| r << a[1]}
    end
  end
end
