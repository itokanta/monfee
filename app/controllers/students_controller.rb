class StudentsController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  before_action :student_choose, except:[:index, :new, :create]
  
  def index
    if user_signed_in?
      @students = Student.where(user_id: current_user.id)
    end
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @attendances = @student.attendances.includes(:fee_plan).order(entry: :desc)
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to student_path(@student)
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to root_path
  end

  private
  def student_params
    params.require(:student).permit(:name, :age, :guardian_name, :phone_number).merge(user_id: current_user.id)
  end

  def student_choose
    @student = Student.find(params[:id])
  end

end