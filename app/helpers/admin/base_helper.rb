# -*- encoding : utf-8 -*-
module Admin::BaseHelper
  def chaos_button_to_show path, options = {}
    chaos_button_to name: '<i class="icol-page"></i> 查看', class: 'btn-small', onclick: "redirectTo('#{path}')"
  end

  def chaos_button_to_edit path, options = {}
    if params[:id].blank? || options[:style] == 'list'
      chaos_button_to name: '<i class="icol-page-white-edit"></i> 编辑', class: 'btn-small', onclick: "redirectTo('#{path}')"
    else
      chaos_button_to name: '编辑', onclick: "redirectTo('#{path}')"
    end
  end

  def chaos_button_to_destroy path, options = {}
    if params[:id].blank? || options[:style] == 'list'
      chaos_button_to name: '<i class="icol-page-white-delete"></i> 删除', class: 'btn-small', onclick: "redirectToDestroy('#{path}')"
    else
      chaos_button_to name: '删除', class: 'btn-danger', onclick: "redirectToDestroy('#{path}')"
    end
  end

  def chaos_button_to_list path
    chaos_button_to name: '返回列表', onclick: "redirectTo('#{path}')"
  end
  
  def chaos_button_to_return name, options = {}
    css_class = "btn #{options[:class]}"
    onclick = options[:onclick] || "redirectTo('#{options[:path]}')"
    raw "<input type=\"button\" class=\"#{css_class}\" onclick=\"#{onclick}\" value=\"#{name}\" />"
  end

  def chaos_button_to options = {}
    name = options[:name] || 'Click'
    css_class = "btn #{options[:class]}"
    onclick = options[:onclick] || "redirectTo('#{options[:path]}')"
    raw "<button type=\"button\" class=\"#{css_class}\" onclick=\"#{onclick}\">#{name}</button>"
  end
  
  def chaos_toolbar_to name, path = nil
    link_to raw(name), path, class: 'btn'
  end

  def chaos_paginate model
    raw "<div class=\"pagination-info\">共#{model.count}条记录 共#{model.total_pages}页</div>#{will_paginate model}"
  end
  
  def chaos_image_tag image, options = {}
    cssClass = options[:border] ? 'border' : ''
    image_url = image.url.blank? ? nil : image.url
    image_url ||= (options[:size].blank? ? nil : "no-image-#{options[:size]}.png")
    image_url.blank? ? '无' : image_tag(image_url, class: cssClass)
  end

  def flash_tag
    if flash[:alert]
      raw "<div class=\"chaos-form-message error\">#{flash[:alert]}</div>"
    elsif flash[:notice]
      raw "<div class=\"chaos-form-message success\">#{flash[:notice]}</div>"
    end
  end
  
  def datetime_tag datetime
    datetime.strftime '%Y-%m-%d %H:%M' unless datetime.blank?
  end
  
  def date_tag date
    date.strftime '%Y-%m-%d' unless date.blank?
  end
  
  def blank_tag value, prompt
    value.blank? ? prompt : value
  end
  
  def boolean_tag boolean
    boolean ? '是' : '否'
  end

  def styled_boolean_tag value, options = {}
    if options[:true_value].blank? or options[:false_value].blank?
      raw value ? "<span class=\"badge badge-success\">Y</span>" : "<span class=\"badge badge-important\">N</span>"
    else
      raw value ? "<span class=\"badge badge-success\">#{options[:true_value]}</span>" : "<span class=\"badge badge-important\">#{options[:false_value]}</span>"
    end
  end
  
  def resource_media_type_tag media_type
    case media_type
      when Resource::MEDIA_TYPE_AUDIO then '音频'
      when Resource::MEDIA_TYPE_VIDEO then '视频'
      when Resource::MEDIA_TYPE_ANIMATION then '动画'
    end
  end
  
  def permission_allowed_tag permission_allowed
    raw permission_allowed ? "<span class=\"badge badge-success\">允许</span>" : "<span class=\"badge badge-important\">禁止</span>"
  end
end
