# -*- encoding : utf-8 -*-
class Thesis < ActiveRecord::Base
  mount_uploader :image, ThesisUploader
  scope :sorted, order('featured DESC, created_at DESC')
  scope :latest, order('featured DESC, displayed_at DESC')
  scope :year_for, ->(year) { where("published_at >= ? AND published_at <= ?", Time.local(year).strftime('%Y-%m-%d'), Time.local(year).end_of_year.strftime('%Y-%m-%d')) }
end
