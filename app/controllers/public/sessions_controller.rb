# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
   posts_path
  end
  
  def after_sign_out_path_for(resource)
   new_contributor_session_path
  end
  
  private

  def contributor_params
    params.require(:contributor).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :postal_code, :address, :telephone_number, :qualification, :profile_image, :introduce, :is_deleted)
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 退会しているかを判断するメソッド
  def contributor_state
    ##入力されたemailからアカウントを1件取得
    @contributor = Contributor.find_by(email: params[:contributor][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@contributor
    ##取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @contributor.valid_password?(params[:contributor][:password]) && (@contributor.is_deleted == true)
      ##退会済みの処理　新規登録画面へ
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
       redirect_to new_contributor_registration_path
    end
  end
  
  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
