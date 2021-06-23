class StudentsController < ApplicationController
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

  private
  def student_params
    params.permit(:name, :age, :guardian_name, :phone_number).merge(user_id: current_user.id)
  end

end