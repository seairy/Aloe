# -*- encoding : utf-8 -*-
class IndividualMember < Member
  
  searchable do
    text :account, :chinese_name, :foreign_name, :organization_name, :dispatched_organization_name, :province, :address, :description
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
end
