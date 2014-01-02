# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  def datetime_tag datetime
    datetime.strftime '%Y-%m-%d %H:%M' unless datetime.blank?
  end
  
  def date_tag date
    date.strftime '%Y-%m-%d' unless date.blank?
  end
  
  def default_image_tag image, options = {}
    image_url = image.url.blank? ? nil : image.url
    image_url ||= (options[:size].blank? ? nil : "no-image-#{options[:size]}.png")
    image_url.blank? ? '无' : image_tag(image_url)
  end
  
  def indent_tag content
    content.start_with?('　　') ? content : content.insert(0, '　　')
  end
  
  def flash_tag
    if flash[:alert]
      raw "<div class=\"notice alert\">#{flash[:alert]}</div>"
    elsif flash[:notice]
      raw "<div class=\"notice\">#{flash[:notice]}</div>"
    end
  end
  
  def signined?
    session[:member]
  end
  
  def side_search_tag
    '搜索'
  end
  
  def side_favorites_tag
    view = "<div class=\"side-row center\">#{link_to image_tag('icon_side_hanban.png'), 'http://www.hanban.org', target: '_blank'}</div>"
    view += "<div class=\"side-row center bold\">#{link_to '网络孔子学院', 'http://www.chinese.cn', target: '_blank'}</div>"
    view += "<div class=\"side-row center bold\">#{link_to '孔子学院大会', 'http://www.chinese.cn/conference/7/', target: '_blank'}</div>"
    view += "<div class=\"side-row center bold\">#{link_to '尼山世界文明论坛', 'http://culture.chinese.cn/nishan/node_12140.htm', target: '_blank'}</div>"
    raw view
  end
  
  def side_seminar_current? seminar
    if seminar.id == params[:id].to_i
      true
    elsif seminar.id == params[:seminar_id].to_i
      true
    elsif !@seminar.blank? and seminar.id == @seminar.id
      true
    end
  end
  
  def side_article_current? category
    id = params[:id] || 0
    if current_page?(controller: 'article_categories', action: 'show', id: id) and category.id == params[:id].to_i
      true
    elsif current_page?(controller: 'articles', action: 'show', id: id) and action_name == 'show' and @article.category.id == category.id
      true
    end
  end
  
  def side_resource_current? category
    id = params[:id] || 0
    if current_page?(controller: 'resource_categories', action: 'show', id: id) and category.id == params[:id].to_i
      true
    elsif current_page?(controller: 'resources', action: 'show', id: id) and @resource.category.id == category.id
      true
    end
  end
  
  def side_topic_current? forum
    id = params[:id] || 0
    if current_page?(controller: 'forums', action: 'show', id: id) and forum.id == params[:id].to_i
      true
    elsif current_page?(controller: 'topics', action: 'show', id: id) and @topic.forum.id == forum.id
      true
    end
  end
  
  def side_thesis_current? year
    id = params[:id] || 0
    if current_page?(controller: 'theses', action: 'index') and year == params[:year].to_i
      true
    elsif current_page?(controller: 'theses', action: 'show', id: id) and @thesis.published_at.strftime('%Y').to_i == year
      true
    end
  end
  
  def side_publication_current? publication
    id = params[:id] || 0
    if current_page?(controller: 'publication_volumes', action: 'index') and publication.id == params[:publication_id].to_i
      true
    elsif current_page?(controller: 'publication_volumes', action: 'show', id: id) and @publication_volume.publication.id == publication.id
      true
    end
  end
  
  def location_tag
    raw("当前位置：#{link_to '首页', root_path} &raquo; " + @location_chain.map {|location| location[:url].blank? ? location[:name] : link_to(location[:name], location[:url])}.join(' &raquo; '))
  end
  
  def book_currency_tag currency
    case currency
    when Book::CURRENCY_RMB then 'RMB'
    when Book::CURRENCY_USD then 'USD'
    end
  end
  
  def book_price_tag book
    if book.price.blank?
      '尚未定价'
    else
      currenty = case book.currency
      when Book::CURRENCY_RMB then 'RMB'
      when Book::CURRENCY_USD then 'USD'
      end
      "#{currenty} #{book.price}"
    end
  end
  
  def member_degree_options
    [['学士', 1], ['硕士', 2], ['博士', 3], ['其它', 4]]
  end
  
  def member_degree_tag degree
    case degree
    when 1 then '学士'
    when 2 then '硕士'
    when 3 then '博士'
    when 4 then '其它'
    end
  end
  
  def member_organization_type_options
    [['高校', 1], ['中学', 2], ['小学', 3], ['孔子学院', 4], ['社会团体', 5], ['出版社', 6], ['教育科技公司', 7], ['培训机构', 8], ['行政单位', 9], ['科研机构', 10], ['其它', 11]]
  end
  
  def member_organization_type_tag organization_type
    case organization_type
    when 1 then '高校'
    when 2 then '中学'
    when 3 then '小学'
    when 4 then '孔子学院'
    when 5 then '社会团体'
    when 6 then '出版社'
    when 7 then '教育科技公司'
    when 8 then '培训机构'
    when 9 then '行政单位'
    when 10 then '科研机构'
    when 11 then '其它'
    end
  end
  
  def member_profit_tag profit
    profit ? '营利' : "非营利"
  end
  
  def contact_gender_tag gender
    case gender
    when Contact::GenderMale then '男'
    when Contact::GenderFemale then '女'
    end
  end
  
  def member_expired_at_tag expired_at
    expired_at.to_s == '2008-01-01' ? '从未缴费' : expired_at
  end
  
  def order_status_tag status
    case status
    when Order::StatusSubmited then '已提交'
    when Order::StatusProcessing then '处理中'
    when Order::StatusInTransit then '配送中'
    when Order::StatusFinished then '已完成'
    end
  end
end
