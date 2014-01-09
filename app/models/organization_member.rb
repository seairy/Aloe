# -*- encoding : utf-8 -*-
require 'ruby-pinyin'
class OrganizationMember < Member
  
  searchable do
    text :account, :chinese_name, :foreign_name, :website, :province, :address, :description
    text :country do |individual_member|
      individual_member.country.name
    end
    text :contacts do |individual_member|
      individual_member.contacts.map { |contact| [contact.name, contact.phone, contact.mobile] }
    end
    text :recipients do |individual_member|
      individual_member.recipients.map { |recipient| recipient.name }
    end
  end
  
  class << self
    def sorted_by_pinyin
      Hash[self.all.map{|m| [PinYin.sentence(m.chinese_name), m]}].sort.inject([]){|r, a| r << a[1]}
    end
  end
end
