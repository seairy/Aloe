# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  def datetime_tag datetime
    datetime.strftime '%Y-%m-%d %H:%M' unless datetime.blank?
  end
  
  def date_tag date
    date.strftime '%Y-%m-%d' unless date.blank?
  end
  
  def side_search_tag
    '搜索'
  end
  
  def side_favorites_tag
    raw '<div class="side-row">
      常用1
    </div>
    <div class="side-row">
      常用2
    </div>
    <div class="side-row">
      常用3
    </div>
    <div class="side-row">
      常用4
    </div>
    <div class="side-row">
      常用5
    </div>'
  end
  
  def location_tag
    '当前位置：xxx'
  end
  
  def book_currency_tag currency
    case currency
    when Book::CURRENCY_RMB then 'RMB'
    when Book::CURRENCY_USD then 'USD'
    end
  end
end
