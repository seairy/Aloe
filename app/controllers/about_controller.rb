# -*- encoding : utf-8 -*-
class AboutController < BaseController
  before_filter :set_location
  
  def introduction
    extend_location_chain '简介'
  end
  
  def rule
    extend_location_chain '章程'
  end
  
  def council
    extend_location_chain '历届理事会'
  end
  
  def distribution
    extend_location_chain '会员分布'
  end
  
  def publication
    extend_location_chain '《世界汉语教学》会刊'
  end
  
  def contact
    extend_location_chain '联系方式'
  end
  
  def guide
    extend_location_chain '入会指南'
  end
  
  def benefit
    extend_location_chain '会员权利'
  end
  
  def application_form
    extend_location_chain '申请表下载'
  end
  
  def faq
    extend_location_chain '常见问题'
  end
  
  protected
  def set_location
    extend_location_chain '关于我们'
  end
end
