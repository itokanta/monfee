class FeePlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fee_plan, only: [:show, :edit, :update, :destroy]

  def index
    @fee_plans = current_user.fee_plans
  end

  def new
    @fee_plan = current_user.fee_plans.build
    restore_from_session(@fee_plan)
  end

  def create
    @fee_plan = current_user.fee_plans.build(fee_plan_params)
    save_fee_plan_with_error_handling('月謝プランが作成されました。') { new_fee_plan_path }
  end

  def edit
    restore_from_session(@fee_plan)
  end

  def update
    @fee_plan.assign_attributes(fee_plan_params)
    save_fee_plan_with_error_handling('月謝プランが更新されました。') { edit_fee_plan_path(@fee_plan) }
  end

  def destroy
    @fee_plan.destroy
    redirect_to fee_plans_path, notice: '月謝プランが削除されました。'
  end

  private

  def set_fee_plan
    @fee_plan = current_user.fee_plans.find(params[:id])
  end

  def fee_plan_params
    params.require(:fee_plan).permit(:name, :amount)
  end

  # セッションからエラー情報と入力値を復元
  def restore_from_session(fee_plan)
    # セッションからエラー情報を復元
    if session[:fee_plan_errors].present?
      fee_plan.errors.add(:base, '') # エラーオブジェクトを初期化
      session[:fee_plan_errors].each do |field, messages|
        messages.each { |message| fee_plan.errors.add(field.to_sym, message) }
      end
      session.delete(:fee_plan_errors)
    end
    
    # セッションから入力値を復元
    if session[:fee_plan_params].present?
      fee_plan.assign_attributes(session[:fee_plan_params])
      session.delete(:fee_plan_params)
    end
  end

  # 月謝プランの保存とエラーハンドリング
  def save_fee_plan_with_error_handling(success_message, &redirect_path_block)
    if @fee_plan.save
      redirect_to fee_plans_path, notice: success_message
    else
      # エラー情報をセッションに保存
      session[:fee_plan_errors] = @fee_plan.errors.messages
      session[:fee_plan_params] = fee_plan_params
      
      redirect_to redirect_path_block.call
    end
  end
end
