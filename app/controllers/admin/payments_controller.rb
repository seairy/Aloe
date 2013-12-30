# -*- encoding : utf-8 -*-
class Admin::PaymentsController < Admin::BaseController
  before_filter :find_member, only: %w{new create}

  def show
    @payment = Payment.find(params[:id])
  end
  
  def new
    @payment = Payment.new
  end
  
  def edit
    @payment = Payment.find(params[:id])
  end
  
  def create
    @member.pay params[:year].to_i, params[:payment][:remark]
    redirect_to [:admin, @member], notice: '缴费成功！'
  end
  
  def update
    @payment = Payment.find(params[:id])
    if @payment.update_attributes(params[:payment])
      redirect_to [:admin, @payment], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    redirect_to admin_payments_path
  end
  
  protected
  def find_member
    @member = Member.find(params[:individual_member_id] || params[:organization_member_id])
  end
end
