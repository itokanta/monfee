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
    restore_from_session(@student)
  end

  def create
    @student = Student.new(student_params)
    save_student_with_error_handling { new_student_path }
  end

  def show
    @attendances = @student.attendances.includes(:fee_plan).order(entry: :desc)
  end

  def edit
    restore_from_session(@student)
  end

  def update
    @student.assign_attributes(student_params)
    save_student_with_error_handling { edit_student_path(@student) }
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

  # セッションからエラー情報と入力値を復元
  def restore_from_session(student)
    # セッションからエラー情報を復元
    if session[:student_errors].present?
      student.errors.add(:base, '') # エラーオブジェクトを初期化
      session[:student_errors].each do |field, messages|
        messages.each { |message| student.errors.add(field.to_sym, message) }
      end
      session.delete(:student_errors)
    end
    
    # セッションから入力値を復元
    if session[:student_params].present?
      student.assign_attributes(session[:student_params])
      session.delete(:student_params)
    end
  end

  # 生徒情報の保存とエラーハンドリング
  def save_student_with_error_handling(&redirect_path_block)
    if @student.save
      redirect_to root_path
    else
      # エラー情報をセッションに保存
      session[:student_errors] = @student.errors.messages
      session[:student_params] = student_params.except(:user_id)
      
      redirect_to redirect_path_block.call
    end
  end

end