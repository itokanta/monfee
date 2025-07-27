class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :student_choose
  before_action :student_entry, only:[:index, :search]
  before_action :attendance_choose, only:[:edit, :update, :destroy]

  def index
  end

  def search
    @q = @attendance.ransack(params[:q])
    @sum = @q.result
  end

  def new
    @attendance = Attendance.new
    @fee_plans = FeePlan.all
  end

  def create
    @attendance = Attendance.new(attendance_params)
    
    # fee_planが選択されている場合、そのプランの金額をfeeに設定
    if params[:attendance][:fee_plan_id].present?
      fee_plan = FeePlan.find(params[:attendance][:fee_plan_id])
      @attendance.fee = fee_plan.amount
    end
    
    if @attendance.save
      redirect_to student_path(@student)
    else
      @fee_plans = FeePlan.all
      render :new
    end
  end

  def edit
    @fee_plans = FeePlan.all
  end

  def update
    # fee_planが選択されている場合、そのプランの金額をfeeに設定
    if params[:attendance][:fee_plan_id].present?
      fee_plan = FeePlan.find(params[:attendance][:fee_plan_id])
      @attendance.fee = fee_plan.amount
    end
    
    if @attendance.update(attendance_params)
      redirect_to student_path(@student)
    else
      @fee_plans = FeePlan.all
      render :edit
    end
  end

  def destroy
    @attendance.destroy
    redirect_to student_path(@student)
  end

  private
  def attendance_params
    params.require(:attendance).permit(:entry, :fee, :fee_plan_id).merge(student_id: params[:student_id])
  end

  def student_entry
    @attendance = Attendance.where(student_id: params[:student_id])
  end

  def student_choose
    @student = Student.find(params[:student_id])
  end

  def attendance_choose
    @attendance = Attendance.find(params[:id])
  end
end
