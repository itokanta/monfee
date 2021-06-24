class StudentsController < ApplicationController
  before_action :student_choose, except:[:index, :new, :create]
  
  def index
  end

  def new
    @students = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to root_path
    else
      render :new
    end
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

  private
  def student_params
    params.permit(:name, :age, :guardian_name, :phone_number).merge(user_id: current_user.id)
  end

  def student_choose
    @student = Student.find(params[:id])
  end

end