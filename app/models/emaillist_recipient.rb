class EmaillistRecipient < ActiveRecord::Base
  belongs_to :emaillist
  scope :available, -> { where(available: true) }

  class << self
    def bulk_create raw_recipients
      raw_recipients.split(/\r\n|\n|\r/).delete_if(&:empty?).each{|r| self.create({ name: r, available: ValidatesEmailFormatOf::validate_email_format(r).nil? })}
    end
  end
end
