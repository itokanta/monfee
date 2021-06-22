class StudentsController < ApplicationController
  def index
  end

  def new
    @students = Student.new
  end

  def create
  end

end