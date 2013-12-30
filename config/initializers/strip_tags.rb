# -*- encoding : utf-8 -*-
class String
  def strip_tags
    ActionController::Base.helpers.strip_tags(self.gsub(/&#?[a-z0-9]+;/i, ''))
  end
end
