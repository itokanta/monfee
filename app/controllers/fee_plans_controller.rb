class FeePlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fee_plan, only: [:show, :edit, :update, :destroy]

  def index
    @fee_plans = FeePlan.all
  end

  def new
    @fee_plan = FeePlan.new
  end

  def create
    @fee_plan = FeePlan.new(fee_plan_params)
    if @fee_plan.save
      redirect_to fee_plans_path, notice: '月謝プランが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @fee_plan.update(fee_plan_params)
      redirect_to fee_plans_path, notice: '月謝プランが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @fee_plan.destroy
    redirect_to fee_plans_path, notice: '月謝プランが削除されました。'
  end

  private

  def set_fee_plan
    @fee_plan = FeePlan.find(params[:id])
  end

  def fee_plan_params
    params.require(:fee_plan).permit(:name, :amount)
  end
end
