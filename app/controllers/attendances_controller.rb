class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :student_choose

  before_action :attendance_choose, only:[:edit, :update, :destroy]
  before_action :set_fee_plans, only:[:new, :create, :edit, :update]


  def new
    @attendance = Attendance.new
    restore_from_session(@attendance)
  end

  def create
    @attendance = Attendance.new(attendance_params)
    save_attendance_with_error_handling { new_student_attendance_path(@student) }
  end

  def edit
    restore_from_session(@attendance)
  end

  def update
    @attendance.assign_attributes(attendance_params)
    save_attendance_with_error_handling { edit_student_attendance_path(@student, @attendance) }
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

  # セッションからエラー情報と入力値を復元
  def restore_from_session(attendance)
    # セッションからエラー情報を復元
    if session[:attendance_errors].present?
      attendance.errors.add(:base, '') # エラーオブジェクトを初期化
      session[:attendance_errors].each do |field, messages|
        messages.each { |message| attendance.errors.add(field.to_sym, message) }
      end
      session.delete(:attendance_errors)
    end
    
    # セッションから入力値を復元
    if session[:attendance_params].present?
      attendance.assign_attributes(session[:attendance_params])
      session.delete(:attendance_params)
    end
  end

  # 出席記録の保存とエラーハンドリング
  def save_attendance_with_error_handling(&redirect_path_block)
    set_fee_from_plan(@attendance)
    
    if @attendance.save
      redirect_to student_path(@student)
    else
      # エラー情報をセッションに保存
      session[:attendance_errors] = @attendance.errors.messages
      session[:attendance_params] = attendance_params.except(:student_id)
      
      redirect_to redirect_path_block.call
    end
  end
end
