# -*- encoding : utf-8 -*-
class Admin::OrdersController < Admin::BaseController
  before_filter :find_member, only: %w{new create}

  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def create
    @member.pay params[:year].to_i, params[:order][:remark]
    redirect_to [:admin, @member], notice: '缴费成功！'
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to [:admin, @order], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  protected
  def find_member
    @member = Member.find(params[:individual_member_id] || params[:organization_member_id])
  end
end
