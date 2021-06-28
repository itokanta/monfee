class AttendancesController < ApplicationController
  before_action :student_choose, except:[:index]

  def index
    @attendance = Attendance.where(student_id: params[:student_id])
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to student_attendances_path(@student)
    else
      render :new
    end
  end

  private
  def attendance_params
    params.require(:attendance).permit(:entry, :fee).merge(student_id: params[:student_id])
  end

  def student_choose
    @student = Student.find(params[:student_id])
  end
end
