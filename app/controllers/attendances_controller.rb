class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :student_choose

  before_action :attendance_choose, only:[:edit, :update, :destroy]
  before_action :set_fee_plans, only:[:new, :create, :edit, :update]


  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)
    
    return unless set_fee_from_plan(@attendance)
    
    if @attendance.save
      redirect_to student_path(@student)
    else
      render :new
    end
  end

  def edit
  end

  def update
    return unless set_fee_from_plan(@attendance)
    
    if @attendance.update(attendance_params)
      redirect_to student_path(@student)
    else
      render :edit
    end
  end

  def destroy
    @attendance.destroy
    redirect_to student_path(@student)
  end

  private
  
  def set_fee_plans
    @fee_plans = current_user.fee_plans
    if @fee_plans.empty?
      redirect_to fee_plans_path, alert: '月謝プランを先に作成してください。'
    end
  end
  
  def set_fee_from_plan(attendance)
    if params[:attendance][:fee_plan_id].present?
      fee_plan = current_user.fee_plans.find(params[:attendance][:fee_plan_id])
      attendance.fee = fee_plan.amount
      attendance.fee_plan = fee_plan
      # fee_plan_nameはモデルのbefore_saveコールバックで自動設定される
      return true
    else
      attendance.errors.add(:fee_plan_id, 'を選択してください')
      render action_name == 'create' ? :new : :edit
      return false
    end
  end
  
  def attendance_params
    params.require(:attendance).permit(:entry, :fee, :fee_plan_id, :fee_plan_name).merge(student_id: params[:student_id])
  end


  def student_choose
    @student = Student.find(params[:student_id])
  end

  def attendance_choose
    @attendance = Attendance.find(params[:id])
  end
end
