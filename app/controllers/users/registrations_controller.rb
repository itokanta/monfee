class Users::RegistrationsController < Devise::RegistrationsController
  # バリデーションエラー時に正しいURLを保持するために、
  # エラー発生時はリダイレクトしてflashメッセージで情報を伝える
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_up!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      # エラー内容をsessionに保存してからリダイレクト
      session[:registration_field_errors] = resource.errors.messages
      session[:registration_params] = sign_up_params.except(:password, :password_confirmation)
      redirect_to new_user_registration_path
    end
  end

  def new
    build_resource
    # 個別フィールドのエラー情報を復元（重複を避けるため、個別フィールドのみ復元）
    if session[:registration_field_errors]
      session[:registration_field_errors].each do |field, messages|
        messages.each do |message|
          resource.errors.add(field, message)
        end
      end
      session.delete(:registration_field_errors)
    end

    # 全体エラーメッセージのクリーンアップ
    if session[:registration_errors]
      session.delete(:registration_errors)
    end
    
    # 入力値を復元
    if session[:registration_params]
      resource.assign_attributes(session[:registration_params])
      session.delete(:registration_params)
    end
    
    yield resource if block_given?
    respond_with resource
  end

  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end
end
