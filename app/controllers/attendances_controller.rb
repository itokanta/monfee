class AttendancesController < ApplicationController
  before_action :student_choose
  before_action :student_entry, only:[:index, :search]
  before_action :search_attendance, only:[:search]
  before_action :attendance_choose, only:[:edit, :update]

  def index
  end

  def search
    @sum = @q.result
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

  def edit
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to student_attendances_path(@student)
    else
      render :new
    end
  end

  private
  def attendance_params
    params.require(:attendance).permit(:entry, :fee).merge(student_id: params[:student_id])
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

  def search_attendance
    @q = Attendance.ransack(params[:q])
  end
end
