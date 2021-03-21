class Admin::HomesController < ApplicationController

     before_action :authenticate_admin!
  def top
    # byebug
    if params[:format].nil?
    #@orders = Order.page(params[:page]).per(10)
    @orders = Order.all
    else
    @orders = Order.where(id: params[:format])
    end
  end
end

